import 'package:flutter/material.dart';
import 'package:mytrain/components/titletext.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.name});

  final String name;

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
            TitleText(text: 'Welcome, ${widget.name}'),
          ],
        ),
      ),
    );
  }
}
