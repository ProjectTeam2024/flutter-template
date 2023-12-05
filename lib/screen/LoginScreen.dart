import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(0xfff3f2f2),
            width: 1.0
        )
    );

    return Scaffold(
      body:  SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Image.asset('asset/logo.png',
                      width: MediaQuery.of(context).size.width / 3 * 2),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  TextFormField(
                    focusNode: _emailFocus,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: baseBorder,),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, _emailFocus, _passwordFocus);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: _passwordFocus,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: baseBorder,),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8 || value.length > 16) {
                        return 'Password must be between 8 and 16 characters';
                      }
                      if (!RegExp(r'(?=.*?[0-9])(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
                        return 'Password must include at least one number, one uppercase, one lowercase letter, and one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // 유효성 검사 통과 시 로그인 처리
                          }
                        },
                        child: const Text('Login'),
                      )
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        context.go('/register');
                      }, child: const Text('sign up')),
                ],
              ),
              ),
            ),
          ),
      ),
    );
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}