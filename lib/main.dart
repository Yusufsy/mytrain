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

class MyApp extends StatefulWidget {

   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    dbHelper.initDB();
    dbHelper.getStoredUser().then((user) {
      setState(() {
        userLoggedIn = user != null;
      });
    });
    print("dbHelper.currentUser");
    print(dbHelper.currentUser);
  }

  bool userLoggedIn = false; 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.light, seedColor: Colors.deepPurple),
      ),
      home: dbHelper.currentUser != null ? MyHomePage(user: dbHelper.currentUser!) : const LoginPage(),
      // const LoginPage(),
    );
  }
}

