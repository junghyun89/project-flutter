import 'dart:io';
import 'package:chat_app2/config/palette.dart';
import 'package:chat_app2/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  final User loggedUser;
  const AddImage({
    super.key,
    required this.loggedUser,
  });

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Palette.activeColor,
            backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          const SizedBox(
            height: 25,
          ),
          if (!kIsWeb)
            OutlinedButton.icon(
              onPressed: () {
                _getCameraImage();
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
            ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
            onPressed: () {
              _getGalleryImage();
            },
            icon: const Icon(Icons.image),
            label: const Text('Gallery'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () {
              addImage();
              Navigator.pop(context);
              setState(() {});
            },
            icon: const Icon(Icons.check),
            label: const Text('Done'),
          )
        ],
      ),
    );
  }

  _getCameraImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
    );
    setState(() {
      if (pickedImageFile != null) {
        pickedImage = File(pickedImageFile.path);
      }
    });
  }

  _getGalleryImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );

    if (pickedImageFile != null) {
      setState(() {
        pickedImage = File(pickedImageFile.path);
      });
    }
  }

  addImage() async {
    final refImage = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child("${widget.loggedUser.uid}.png");

    await refImage.putFile(pickedImage!);
    final url = await refImage.getDownloadURL();
    DatabaseService(uid: widget.loggedUser.uid).setUserImage(url);
  }
}
