import 'package:flutter/material.dart';
import 'package:mytrain/components/titletext.dart';
import 'package:mytrain/models/user.dart';
import 'package:mytrain/booktrainpage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.user});

  final User user;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            TitleText(text: 'Welcome, ${widget.user.fullname}'),
            SizedBox(height: 20),
            Text('Book a Ticket', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
            // Add more dashboard content here that will display option to pick a train and book tickets
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookTrain()),
                );
              },
              child: Text('Pick a Train'),
            ),
          ],
        ),
      ),
    );
  }
}
