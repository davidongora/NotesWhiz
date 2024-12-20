import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:notes/shared/buttons.dart';
import 'package:notes/shared/fields.dart';

class EditMyProfile extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditMyProfile({super.key, required this.user});

  @override
  State<EditMyProfile> createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data
    nameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!) as ImageProvider
                          : const AssetImage('assets/rb.png'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Choose from Gallery'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Take a Photo'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'Change Profile Photo',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Name Input Field
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),

                // Email Input Field
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // Save Button fixed at the bottom
          Align(
              alignment: Alignment.bottomCenter,
              child: Buttons(buttonText: 'Save')
              // child: Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              //   color: Colors.blue,
              // child:  const Buttons(
              //   buttonText: 'Save',
              // style: ElevatedButton.styleFrom(
              //   foregroundColor: Colors.black,
              //   backgroundColor: Colors.white,
              // ),
              // onPressed: () {
              //   print('Name: ${nameController.text}');
              //   print('Email: ${emailController.text}');
              //   if (_selectedImage != null) {
              //     print('Selected Image Path: ${_selectedImage!.path}');
              //   }
              // },
              // child: const Text('Save'),
              // ),
              ),
          // ),
        ],
      ),
    );
  }
}
