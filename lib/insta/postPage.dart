import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/insta/upload.dart';

import '../classModel/PostClass.dart';
import '../juiceHub/data.dart';
import 'edit.dart';

var url;
PostClass? postobj;

class postPage extends StatefulWidget {
  const postPage({Key? key}) : super(key: key);

  @override
  State<postPage> createState() => _postPageState();
}

class _postPageState extends State<postPage> {
  bool _isBackdropVisible = false;

  //to cerate function to get image
  Future<void> _getImage(ImageSource source) async {
    XFile? image;
    final pickedImage = await imagePicker.pickImage(source: source);

    setState(() {
      {
        image = pickedImage;
      }
    });
    //path setting for image put into firebase storage

    if (image != null) {
      var ref = FirebaseStorage.instance.ref().child(
          '/ramees/images/${DateTime.now()}'); // Fixed typo here, added missing '/'
      UploadTask uploadTask = ref.putFile(File(image!.path));
      await uploadTask.whenComplete(() async {
        url = await ref.getDownloadURL();

        postobj = PostClass(
            pid: null,
            postName: url.toString(),
            uid: myPro.uid,
            uploadTime: Timestamp.now(),
            likes: []);

        setState(() {});
      });
    }
  }

  Future<void> getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {}
    });
  }

  void _toggleBackdropVisibility() {
    setState(() {
      _isBackdropVisible = !_isBackdropVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BackdropScaffold(
            appBar: BackdropAppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blueAccent],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.7],
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.backward),
              ),
              title: Text('My post'),
              actions: [
                BackdropToggleButton(
                  icon: AnimatedIcons.list_view,
                ),
                IconButton(
                  onPressed: () {
                    _toggleBackdropVisibility();
                  },
                  icon: Icon(CupertinoIcons.plus),
                ),
              ],
            ),
            backLayer: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 500,
                    child: (url == null)
                        ? Icon(
                            Icons.image,
                            // fill: double.maxFinite,
                          )
                        : Image.network(url),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
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
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
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
                              'gallery',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                          .transparent), // Make the ElevatedButton transparent
                      shadowColor: MaterialStateProperty.all<Color>(
                          Colors.transparent), // Remove the shadow
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(myPro.uid)
                          .collection('post')
                          .add(postobj!.toJson())
                          .then((value) {
                        DocumentReference ref = FirebaseFirestore.instance
                            .collection('user')
                            .doc(myPro.uid)
                            .collection('post')
                            .doc(value.id);

                        postobj =
                            postobj!.copyWith(pid: value.id, reference: ref);
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(myPro.uid)
                            .collection('post')
                            .doc(value.id)
                            .update(postobj!.toJson());
                      });
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
                          'confirm',
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
            frontLayer: Container(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    // child: GridView.builder(
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisSpacing: 5,
                    //     mainAxisSpacing: 5,
                    //     crossAxisCount: 2,
                    //   ),
                    //   itemCount: 10,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(top: 10),
                    //       child: Container(
                    //         color: Colors.blue,
                    //         height: 60,
                    //       ),
                    //     );
                    //   },
                    // )
                    child: StreamBuilder<List<PostClass>>(
                        stream: getPost(),
                        builder: (context, snapshot) {
                          var data = snapshot.data;

                          {
                            return Container(
                              child: GridView.builder(
                                itemCount: data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 300,
                                    child: Image(
                                        image: NetworkImage(
                                            data[index].postName.toString())),
                                  );
                                },
                              ),
                            );
                          }
                        })))));
  }
}

//to get
Stream<List<PostClass>> getPost() {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(myPro.uid)
      .collection("post")
      .snapshots()
      .map((event) =>
          event.docs.map((e) => PostClass.fromJson(e.data())).toList());
}
