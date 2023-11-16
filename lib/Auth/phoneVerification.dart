import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'otp.dart';

String smsCode = '';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //verify the phone numbe and send otp
  Future<void> verifyPhoneNumber(BuildContext context) async {
    try {
      auth.verifyPhoneNumber(
        phoneNumber: '+91${_phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (mounted) {
            final snackBar = SnackBar(content: Text("Otp get successfully"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('-------');
          print(e.message);
          print('-------');
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            smsCode = verficationID!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          if (mounted) {
            setState(() {
              smsCode = verificationID;
            });
          }
        },
        timeout: const Duration(seconds: 9),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Icon(CupertinoIcons.phone_circle,
                    size: 150, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter a phone number';
                    }
                    if (value.length != 10) {
                      return 'please enter a valid number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(CupertinoIcons.phone),
                        onPressed: () {},
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'enter your phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validate the form
                    verifyPhoneNumber(context).then((value) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return otp(
                          phoneNumber: _phoneController.text,
                        );
                      }));
                    });
                  }
                },
                child: Container(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
