// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/services/auth.dart';
import 'package:pay_share/shared/constants.dart';
import 'package:pay_share/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFFCFCFC),
            body: Column(
              children: [
                SizedBox(
                  height: 125,
                ),
                Text(
                  'Login Now',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 21,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    'Please login to continue using the app.',
                    style: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 45,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            maxLines: 1,
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 15,
                              ),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter an email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 15,
                              ),
                            ),
                            validator: (val) {
                              if (val.length < 6) {
                                return 'Enter a longer password';
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 305,
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailandPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'sign in failed';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(78, 10, 5, 0),
                          child: Row(
                            children: [
                              Text(
                                'Don\'t have an account?  ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: SizedBox(
                                  height: 13,
                                  width: 40,
                                  child: Container(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.blue[600],
                                          fontSize: 11),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
