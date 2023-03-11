import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      notifyListeners();
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
}
