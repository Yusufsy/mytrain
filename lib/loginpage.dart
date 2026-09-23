import 'package:flutter/material.dart';
import 'package:mytrain/homepage.dart';
import 'package:mytrain/signuppage.dart';
import 'package:mytrain/models/user.dart';
import 'package:mytrain/helpers/db-helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordHidden = true;
  String? _email;
  String? _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0, right:16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset("assets/images/train-app-logo.png", width: 300, height: 300),
                      Text(
                      'Login to MyTrain',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                     TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                     TextFormField(
                      obscureText: _isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Handle login logic here
                        if (_formKey.currentState!.validate()) {

                          // final decryptedPassword = DBHelper().decryptPassword( _password!);
                          // print('Decrypted Password: $decryptedPassword');
                          // Handle login logic here
                          User? loginSuccess = await DBHelper().login(_email!, _password!);
                          if(loginSuccess != null){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage(user: loginSuccess)),
                            );
                          } else {
                            print('Invalid email or password.');
                            SnackBar snackBar = const SnackBar(
                              content: Text('Invalid email or password.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        } else {
                          print('Please enter both email and password.');
                          SnackBar snackBar = const SnackBar(
                            content: Text('Please enter both email and password.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password logic here
                      },
                      child: const Text('Forgot Password?'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to signup page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}