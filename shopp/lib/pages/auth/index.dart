import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/auth.provider.dart';
import 'package:shopp/types/exception/http_exception.dart';

enum AuthMode { signUp, signIn }

class PageAuth extends StatelessWidget {
  static const route = '/auth';

  const PageAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 255, 115, 0.498),
                    Color.fromRGBO(124, 245, 253, 0.898)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1])),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.shade700,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: const Text(
                      'shoplee',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton'),
                    ),
                  )),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  )
                ]),
          ),
        )
      ]),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.signIn;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordEdittingController = TextEditingController();

  void _submit() async {
    final currentFormState = _formKey.currentState;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (currentFormState == null || !currentFormState.validate()) {
      return;
    }
    currentFormState.save();
    setState(() {
      _isLoading = true;
    });
    var errMesage = null;
    try {
      if (_authMode == AuthMode.signIn) {
        await authProvider.signIn(
            _authData['email'] ?? '', _authData['password'] ?? '');
      } else {
        await authProvider.signUp(
            _authData['email'] ?? '', _authData['password'] ?? '');
      }
    } on HttpException catch (err) {
      errMesage = AuthProvider.errorMessages[err.toString()] ?? err.toString();
    } catch (err) {
      errMesage = 'Unknown error. Please try again later';
    }
    if (errMesage != null) {
      _showAlertDialog(errMesage, title: 'Authentication Failed');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showAlertDialog(String message, {String? title}) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: title != null ? Text(title) : null,
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }

  void _toggleAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isSignInMode = _authMode == AuthMode.signIn;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: Container(
        // height: isSignInMode ? 260 : 320,
        constraints: BoxConstraints(minHeight: isSignInMode ? 260 : 320),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || !val.contains('@')) {
                          return 'Please input a valid email';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _authData['email'] = val ?? '';
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordEdittingController,
                      validator: (val) {
                        if (val == null || val.length < 5) {
                          return 'Password must be longer than 4 characters';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _authData['password'] = val ?? '';
                      },
                    ),
                    if (!isSignInMode)
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Confirm assword'),
                        obscureText: true,
                        validator: isSignInMode
                            ? null
                            : (val) {
                                if (_passwordEdittingController.text != val) {
                                  return 'Password do not match';
                                }
                                return null;
                              },
                        onSaved: (val) {
                          _authData['password'] = val ?? '';
                        },
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_isLoading) ...[
                      const CircularProgressIndicator()
                    ] else ...[
                      ElevatedButton(
                        onPressed: _submit,
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8))),
                        child: Text(isSignInMode ? 'Sign in' : 'Sign up'),
                      )
                    ],
                    TextButton(
                      onPressed: _toggleAuthMode,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: Text(isSignInMode ? 'or Sign up' : 'or Sign in'),
                    )
                  ],
                ))),
      ),
    );
  }
}
