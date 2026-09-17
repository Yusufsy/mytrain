import 'package:flutter/material.dart';
import 'package:mytrain/models/user.dart';
import 'package:mytrain/dashboard.dart';
import 'package:mytrain/tickets.dart';
import 'package:mytrain/profilepage.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.user});
  final User user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    DashboardPage(name: user?.fullname ?? 'User'),
    Tickets(),
    ProfilePage(currentUser: user ?? User(id: '0')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 182, 209, 255),
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'My Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
