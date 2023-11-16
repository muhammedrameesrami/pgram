import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/homepage.dart';
import 'package:ui/Auth/phoneVerification.dart';
import 'package:ui/Auth/signin.dart';
import 'package:ui/insta/upload.dart';

import '../classModel/UsersModel.dart';
import '../insta/detailofuser.dart';

final formkey = GlobalKey<FormState>();

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final focus = FocusNode();

  getUser({required String emil, required String pass}) {
    FirebaseFirestore.instance
        .collection('user')
        .doc("uFThiaR2wGbkpbi2C2I1sbHYSVr2u")
        .update({'date': DateTime.now()});
  }

  getUserNow() {
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        element.reference.update({"reference": element.reference});
      });
    });
  }

  @override
  void initState() {
    _passwordVisible = false;
    getData(context);
    super.initState();
  }

  late bool _passwordVisible = false;

  TextEditingController pass = TextEditingController();
  TextEditingController emil = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.all(110),
                  child: Icon(
                    CupertinoIcons.person_alt_circle,
                    size: 150,
                    color: Colors.white,
                  )),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emil,
                        autofocus: true,
                        // textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(focus);
                        },
                        onTap: () => pass.clear(),
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
                        height: 30,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: pass,
                        obscureText: !_passwordVisible,
                        focusNode: focus,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).hintColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 4) {
                            return 'password must be at least 4 characters ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  final isValidForm =
                                      formkey.currentState!.validate();
                                  if (isValidForm) {
                                    SignInHandler(
                                        email: emil.text,
                                        password: pass.text,
                                        context: context);
                                  }
                                },
                                icon: Icon(Icons.forward)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                getUser() {
                                  email:
                                  emil;
                                  password:
                                  pass;
                                }

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Sign(
                                        phoneNumber: '',
                                      ),
                                    ));
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.blue),
                              )),
                          TextButton(
                              onPressed: () {
                                final isValidForm =
                                    formkey.currentState!.validate();
                                if (isValidForm) {
                                  PasswordResetHandler.resetPassword(
                                      emil.text, context);
                                }
                              },
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.blue),
                              )),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneVerification()));
                          },
                          child: Text(
                            'phone verification',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.blue),
                          ))
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

// reset pasword using phon eand email
class PasswordResetHandler {
  static void resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey.shade100,
          title: Text(
            ' Reset The Password',
            style: TextStyle(color: Colors.black),
          ),
          content: Text('please verify is it you and check the your email',
              style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred. Please try again later.'),
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

Future<UsersModel?> getUser({required String id, required String email}) async {
  if (id != '' && email == '') {
    DocumentSnapshot<dynamic> snapshot =
        await FirebaseFirestore.instance.collection('user').doc(id).get();
    if (snapshot.exists) {
      usersModel = UsersModel.fromJson(snapshot.data()!);
      currentUserId = usersModel!.uid!;
      return usersModel;
    }
  } else {
    QuerySnapshot<dynamic> snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('uid', snapshot.docs.first.id);
      usersModel = UsersModel.fromJson(snapshot.docs.first.data());
      currentUserId = usersModel!.uid!;
      return usersModel;
    }
  }
  return null;
}

SignInHandler(
    {required String email,
    required String password,
    required BuildContext context}) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) async {
    print('case 1');
    usersModel = await getUser(id: '', email: email);
    print(usersModel!.name);
    print('case 2');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    print('case 3');
  }).onError((error, stackTrace) {
    var snackBar = SnackBar(content: Text(error.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
//
// class SignInHandler {
//   static void signInWithEmailAndPassword({
//     required String email,
//     required String password,
//     required BuildContext context,
//     // Add the onLoginSuccess callback function
//     void Function()? onLoginSuccess,
//   }) {
//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) async {
//       // currentUserId = value.user!.uid;
//       // setData();
//       usersModel = await getUser(id: '', email: email);
//       await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//       // Call the onLoginSuccess callback if provided
//       if (onLoginSuccess != null) {
//         onLoginSuccess();
//       }
//     }).catchError((error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invalid username or password'),
//         ),
//       );
//     });
//   }
// }

// Function to store the login date in SharedPreferences and i used in signout functoin the setdat is in the signin function after then
//and getdat function is inte after state
Future<void> setData(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('uid', currentUserId);
}

Future<void> getData(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var a = preferences.getString('uid');
  if (a != null) {
    currentUserId = a;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
