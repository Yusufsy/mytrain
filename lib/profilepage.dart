import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mytrain/components/profile-avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytrain/helpers/db-helper.dart';
import 'package:mytrain/loginpage.dart';
import 'package:mytrain/models/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Uint8List? _image;
  ImageSource _imageSource = ImageSource.camera;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ProfileAvatar(imagePath: _image),
            SizedBox(height: 20),
            ListTile(title: Text('Edit Profile'), leading: Icon(Icons.edit), 
            onTap: () async {

              await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Media Selection'),
                        content: Text(
                            'Select the source for your new profile picture.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _imageSource = ImageSource.camera;
                              Navigator.of(context).pop();
                            },
                            child: Text('Camera'),
                          ),
                          TextButton(
                            onPressed: () {
                              _imageSource = ImageSource.gallery;
                              Navigator.of(context).pop();
                            },
                            child: Text('Gallery'),
                          ),
                        ],
                      );
                    },
                  );
              // pick an image
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: _imageSource);
              final CroppedFile? croppedFile = await ImageCropper().cropImage(
                sourcePath: image!.path,
                uiSettings: [
                  AndroidUiSettings(
                      toolbarTitle: 'Crop Profile Photo',
                      toolbarColor: Colors.blueAccent,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false),
                ],
              );
              if (croppedFile != null) {
                final imageBytes = await croppedFile.readAsBytes();
                setState(() {
                  _image = imageBytes;
                });
              }
            },
            ),
            ListTile(title: Text('Change Password'), leading: Icon(Icons.lock)),
            ListTile(
              title: Text('Terms and Conditions'),
              leading: Icon(Icons.description),
              onTap: () async {
                // Handle terms and conditions tap
                await launchUrl(Uri.parse('https://www.termsfeed.com/blog/sample-terms-and-conditions-template/'));
              },
            ),
            ListTile(title: Text('Contact Us'), leading: Icon(Icons.message),
            onTap: () async {
              // launch whatsapp with prefilled message
              final Uri whatsappUrl = Uri.parse('https://wa.me/2348134567890?text=Hello%20MyTrain%20Support%20Team');
              await launchUrl(whatsappUrl);
            },),
            ListTile(title: Text('Logout'), leading: Icon(Icons.logout), onTap: () {
              // Handle logout action
              
              print('Logout action triggered');
              Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
            },),
            Opacity(
              opacity: 0.3,
              child: ListTile(
                title: Text('Delete Account'),
                leading: Icon(Icons.delete),
                onLongPress: () async {
                  // Handle delete account action
                  print('Delete account action triggered');

                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Delete Account'),
                        content: Text(
                            'Are you sure you want to delete your account? This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Perform delete account action here
                              final dbHelper = DBHelper();
                              final success = await dbHelper.deleteUser(int.parse(widget.currentUser.id));
                              if (success) {
                                print('Account deleted');
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              } else {
                                print('Failed to delete account');
                              }
                            },
                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
