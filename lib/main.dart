import 'package:flutter/material.dart';
import 'package:mytrain/loginpage.dart';
import 'package:mytrain/homepage.dart';
import 'package:mytrain/models/user.dart';
import 'package:mytrain/helpers/db-helper.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper().initDB(); // Initialize the database
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  bool userLoggedIn = false; // Replace with your actual logic to check if the user is logged in
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.light, seedColor: Colors.deepPurple),
      ),
      home: userLoggedIn ? MyHomePage(user: User(id: '1', fullname: 'Yusuf', email: "yusuf@mail.com", password: "")) : const LoginPage(),
      // const LoginPage(),
    );
  }
}

