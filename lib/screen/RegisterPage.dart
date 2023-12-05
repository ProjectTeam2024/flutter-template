import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/');
          },
        ),
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
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
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
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
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8 || value.length > 16) {
                        return 'Password must be between 8 and 16 characters';
                      }
                      if (!RegExp(r'(?=.*?[0-9])(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
                        return 'Password must include at least one number, one uppercase, one lowercase letter, and one special character';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, _passwordFocus, _confirmPasswordFocus);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: _confirmPasswordFocus,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: baseBorder,),
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value != _password) {
                        return 'Passwords do not match';
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
                            context.go('/');
                          }
                        },
                        child: const Text('Save'),
                      )
                  ),
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