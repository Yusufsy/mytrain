import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text,this.fontColor});

  final String text;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: fontColor ?? Colors.blueAccent,
      ),
    );
  }
}
