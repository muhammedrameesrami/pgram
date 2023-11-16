import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ui/insta/detailofuser.dart';

import '../classModel/UsersModel.dart';
import '../homepage.dart';

class Sign extends StatefulWidget {
  const Sign({super.key, required this.phoneNumber});
  final String? phoneNumber;

  @override
  State<Sign> createState() => _State();
}

// <meta name="google-signin-client_id" content="your-client_id.apps.googleusercontent.com">
class _State extends State<Sign> {
  TextEditingController uname = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController? nmbr = TextEditingController();
  TextEditingController pswd = TextEditingController();
  TextEditingController cpswd = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    nmbr = TextEditingController(text: widget.phoneNumber);
    print('---------------------------------------');
    print(widget.phoneNumber);
    super.initState();
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.backward,
                  color: Colors.white,
                  size: 35,
                )),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 35, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                    Icon(
                      CupertinoIcons.person_crop_circle_badge_plus,
                      color: Colors.white,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.16,
                    right: 35,
                    left: 35),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: uname,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'User Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a username';
                          }
                          // ... Other validation logic ...
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: mail,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: nmbr,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onFieldSubmitted: (phonenumber) {},
                          validator: (nmbr) {
                            if (nmbr != null && nmbr.length < 10) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: pswd,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 8) {
                              return 'password must be at least 8 characters ';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                          controller: cpswd,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Confirm Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null) {
                              return 'This field is required';
                            }
                            if (value.trim() != pswd.text.trim()) {
                              return 'password do not match ';
                            }

                            return null;
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  final isValidForm =
                                      formkey.currentState!.validate();
                                  if (isValidForm) {
                                    SignUpHandler.signUpWithEmailAndPassword(
                                      email: mail.text,
                                      password: pswd.text,
                                      userName: uname.text,
                                      phoneNumber: widget.phoneNumber!,
                                      context: context,
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.forward,
                                  size: 30,
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              GoogleSignInHandler().signInWithGoogle(context);
                            },
                            child: Container(
                              height: 24,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                              ),
                              child: Center(child: Text("Google sign ")),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Signin whit details and store firebase
class SignUpHandler {
  static void signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName,
      required String phoneNumber,
      required BuildContext context}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        int? count;
        await FirebaseFirestore.instance
            .collection('settings')
            .doc('settings')
            .update({'userId': FieldValue.increment(1)});
        await FirebaseFirestore.instance
            .collection('settings')
            .doc('settings')
            .get()
            .then((value) {
          count = int.tryParse(value.data()!['userId'].toString());
        });
        int now = Timestamp.now().seconds;
        DocumentReference reference =
            FirebaseFirestore.instance.collection('user').doc('$now-$count');
        currentUserId = "$now-$count";
        final data = UsersModel(
          reference: reference,
          uid: '$now -$count',
          email: value.user!.email,
          name: userName,
          profile: '',
          phone: phoneNumber,
          createdDate: Timestamp.now(),
          loginDate: Timestamp.now(),
          follow: [],
          password: password,
        );
        currentUserId = "$now-$count";
        await FirebaseFirestore.instance
            .collection("user")
            .doc('$now-$count')
            .set(data.toJson());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } catch (e) {
      print('Error signup up: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'An error occurred while signup up. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

//google signup
class GoogleSignInHandler {
  void signInWithGoogle(BuildContext context) async {
    try {
      // Sign in with Google on mobile (Android).
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleUser == null || googleAuth == null) {
        print('Google Sign-in cancelled or failed.');
        return;
      }

      // Get Google credentials.
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase Auth using the credentials.
      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        int? count;
        if (value.additionalUserInfo!.isNewUser) {
          //her we create a custom document id
          await FirebaseFirestore.instance
              .collection('settings')
              .doc('settings')
              .update({'userId': FieldValue.increment(1)});
          await FirebaseFirestore.instance
              .collection('settings')
              .doc('settings')
              .get()
              .then((value) {
            count = int.tryParse(value.data()!['userId'].toString());
          });
          int now = Timestamp.now().seconds;
          DocumentReference reference =
              FirebaseFirestore.instance.collection('user').doc('$now-$count');
          var userData = UsersModel(
            reference: reference,
            uid: "$now-$count",
            email: googleUser.email,
            name: googleUser.displayName ?? '',
            profile: googleUser.photoUrl,
            phone: '',
            createdDate: Timestamp.now(),
            loginDate: Timestamp.now(),
            follow: [],
            password: '',
          );
          FirebaseFirestore.instance
              .collection('user')
              .doc('$now-$count')
              .set(userData.toJson());
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        }
      });

      if (userCredential?.user == null) {
        print('Error signing in with Google.');
        return;
      }

      // Navigate to the HomePage after successful sign-in.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle sign-in error if needed.
    }
  }
}
