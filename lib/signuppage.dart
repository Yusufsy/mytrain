import 'package:flutter/material.dart';
import 'package:mytrain/loginpage.dart';
import 'package:mytrain/homepage.dart';
import 'package:mytrain/models/user.dart';
import 'package:mytrain/helpers/db-helper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPasswordHidden = true;
  String? _fullName;
  String? _email;
  String? _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      'Signup to MyTrain',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _fullName = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
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
                          // Handle login logic here
                          final User newUser = User(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            fullname: _fullName,
                            email: _email,
                            password: _password,
                          ); 


                          // final encryptedPassword = DBHelper().encryptPassword(_password!);
                          // print('Encrypted Password: $encryptedPassword');
                          await DBHelper().signup({
                            'fullName': _fullName,
                            'email': _email,
                            'password': _password,
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage(user: newUser)),
                            );

                        } else {
                          print('Please enter both email and password.');
                          SnackBar snackBar = const SnackBar(
                            content: Text('Please enter both email and password.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text('Signup'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text('Already have an account? Login'),
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