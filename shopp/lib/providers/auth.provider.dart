import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopp/types/exception/http_exception.dart';
import 'package:shopp/types/http.dart';

class AuthProvider with ChangeNotifier {
  static const Map<String, String> errorMessages = {
    'EMAIL_EXISTS': 'An account has already existed with this email',
    'INVALID_EMAIL': 'Invalid email address',
    'WEAK_PASSWORD': 'Password is too weak',
    'EMAIL_NOT_FOUND': 'Could not find a user with this email',
    'INVALID_PASSWORD': 'Invalid password',
  };

  String? _authToken;
  DateTime? _expiresIn;
  String? _uid;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get uid {
    return _uid;
  }

  String? get token {
    if (_expiresIn != null &&
        _expiresIn!.isAfter(DateTime.now()) &&
        _authToken != null) {
      return _authToken;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password,
      {bool signin = true}) async {
    try {
      final res = await http.post(
          signin ? AuthHTTP.signInUrl : AuthHTTP.signUpUrl,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final resBody = jsonDecode(res.body);
      if (resBody['error'] != null) {
        final err = resBody['error'];
        throw HttpException(err['code'], message: err['message']);
      }
      _authToken = resBody['idToken'];
      _uid = resBody['localId'];
      _expiresIn = DateTime.now()
          .add(Duration(seconds: int.parse(resBody['expiresIn'])));
      _setAutoLogoutTimer();
      notifyListeners();
      save();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) {
    return _authenticate(email, password, signin: false);
  }

  Future<void> signIn(String email, String password) {
    return _authenticate(email, password, signin: true);
  }

  void logout() async {
    _authToken = null;
    _uid = null;
    _expiresIn = null;
    _cancelCurrentTimer();
    await clear();
    notifyListeners();
  }

  void _cancelCurrentTimer() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
  }

  void _setAutoLogoutTimer() {
    _cancelCurrentTimer();
    final timeTilExpire = _expiresIn?.difference(DateTime.now()).inSeconds ?? 0;
    _authTimer = Timer(Duration(seconds: timeTilExpire), logout);
  }

  void save() async {
    if (!isAuth) {
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final authData = jsonEncode({
        'auth': _authToken,
        'uid': _uid,
        'expires': _expiresIn?.toIso8601String(),
      });
      prefs.setString('user', authData);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<bool> tryLoad() async {
    try {
      // await Future.delayed(const Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('user')) {
        return false;
      }
      final authData =
          jsonDecode(prefs.getString('user') ?? '{}') as Map<String, dynamic>;
      final expires = DateTime.parse(authData['expires']!);
      if (expires.isBefore(DateTime.now())) {
        return false;
      }
      _authToken = authData['auth'];
      _uid = authData['uid'];
      _expiresIn = expires;
      _setAutoLogoutTimer();
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
