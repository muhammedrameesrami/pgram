import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/insta/upload.dart';

import '../juiceHub/data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final imagePicker = ImagePicker();

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  File? _image;
  var url;
  //to cerate function to get image
  Future<void> _getImage(ImageSource source) async {
    XFile? image;
    final pickedImage = await imagePicker.pickImage(source: source);

    setState(() {
      {
        image = pickedImage;
      }
    });
    //path setting for image putto firebase storage
    var ref = FirebaseStorage.instance
        .ref()
        .child('/ramees/images ${DateTime.now()}');
    UploadTask uploadTask = ref.putFile(File(image!.path));
    uploadTask.then((p0) async {
      url = (await ref.getDownloadURL()).toString();
    }).then((value) {
      setState(() {
        myPro = myPro.copyWith(profile: url);
      });
      FirebaseFirestore.instance
          .collection('user')
          .doc(myPro.uid)
          .update(myPro.toJson());
    });
  }

  Future<void> getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController =
      TextEditingController(text: myPro.name);
  TextEditingController _emailController =
      TextEditingController(text: myPro.email);
  TextEditingController _phoneController =
      TextEditingController(text: myPro.phone);

  @override
  void initState() {
    super.initState();
    // Fetch the current user data from Firebase and set the initial values of the controllers
    _loadUserData();
  }

  // Fetch the current user data from Firebase and set the initial values of the controllers
  Future<void> _loadUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      Map<String, dynamic> userData =
          userDataSnapshot.data() as Map<String, dynamic>;
      _nameController.text = userData['name'];
      _emailController.text = userData['email'];
      _phoneController.text = userData['phoneNumber'];
      String imageUrl = userData['imageUrl'];
      if (imageUrl.isNotEmpty) {
        setState(() {
          _image = File(imageUrl);
        });
      }
    }
  }

  // Update the user's profile data in Firebase
  Future<void> _updateUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        // Update user data
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'name': _nameController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneController.text,
        });

        // Upload image if it exists
        if (_image != null) {
          String fileName = currentUser.uid + DateTime.now().toString();
          firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance.ref().child(fileName);
          await ref.putFile(_image!);
          String imageUrl = await ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .update({'imageUrl': imageUrl});
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile updated successfully!'),
        ));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error updating profile: $error'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.4, 0.7],
                tileMode: TileMode.repeated,
              ),
            ),
          ),
          title: Center(child: Text('Edit ')),
        ),
        body: Column(
          children: [
            Container(
              child: Image.network(
                myPro.profile.toString(),
                fit: BoxFit.cover,
              ),
              height: 250,
              width: double.infinity,
              color: Colors.transparent,
              // child: _image != null
              //     ? Image.network(
              //         myPro.profile.toString(),
              //         fit: BoxFit.fill,
              //       )
              //     : Icon(
              //         Icons.image,
              //         size: 100,
              //         color: Colors.grey,
              //       )),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      _getImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .transparent, // Make the ElevatedButton transparent
                      shadowColor: Colors.transparent, // Remove the shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Customize the button's borderRadius
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // Match the button's borderRadius
                      ),
                      child: Container(
                        height: 25,
                        alignment: Alignment.center,
                        child: Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _getImage(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors
                        .transparent, // Make the ElevatedButton transparent
                    shadowColor: Colors.transparent, // Remove the shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Customize the button's borderRadius
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(
                          10), // Match the button's borderRadius
                    ),
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: Text(
                        'uploadimage',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .transparent), // Make the ElevatedButton transparent
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent), // Remove the shadow
                      ),
                      onPressed: () {
                        //here firest my contoler name what i wnat to change then pass my id to jason
                        myPro = myPro.copyWith(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text);
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(myPro.uid)
                            .update(myPro.toJson());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Upload()));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.blueAccent
                            ], // Use your desired gradient colors
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(
                              10), // Customize the button's borderRadius
                        ),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18), // Customize the text style
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
