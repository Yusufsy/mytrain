import 'package:flutter/material.dart';
import 'dart:typed_data';
class ProfileAvatar extends StatelessWidget {
  final Uint8List? imagePath;
  const ProfileAvatar({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return 
    Center(child: CircleAvatar(
      radius: 200,
      backgroundImage: imagePath != null ? MemoryImage(imagePath!) : AssetImage('assets/images/train-app-logo.png') as ImageProvider,
    ));
  }
}