import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/Auth/phoneVerification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui/Auth/signin.dart';

class otp extends StatefulWidget {
  const otp({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();

  final a = FocusNode();
  final b = FocusNode();
  final c = FocusNode();
  final d = FocusNode();
  final e = FocusNode();
  final f = FocusNode();

  //otp getting
  Future<void> signInWithOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: smsCode,
      smsCode: (t1.text + t2.text + t3.text + t4.text + t5.text + t6.text),
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Sign(phoneNumber: widget.phoneNumber),
            );
          },
        ));
      });
      // Verification is complete, navigate to the next screen
      // Here you might want to navigate to a profile setup screen or something similar.
    } catch (e) {
      print('Error signing in with OTP: ${e.toString()}');
      final snackBar = SnackBar(content: Text("otp get successfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.white,
                  backgroundColor: Colors.red),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Enter your 6 digit otp',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 40,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: t1,
                  focusNode: a,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(b);
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: t2,
                  focusNode: b,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(c);
                    } else {
                      FocusScope.of(context).requestFocus(a);
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: t3,
                  focusNode: c,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(d);
                    } else {
                      FocusScope.of(context).requestFocus(b);
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: t4,
                  focusNode: d,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(e);
                    } else {
                      FocusScope.of(context).requestFocus(c);
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: t5,
                  focusNode: e,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(f);
                    } else {
                      FocusScope.of(context).requestFocus(d);
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: t6,
                  focusNode: f,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    } else {
                      FocusScope.of(context).requestFocus(e);
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
            ],
          ),
          TextButton(onPressed: () {}, child: Text('resend otp')),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Sign(
                            phoneNumber: widget.phoneNumber,
                          )));
            },
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          )
        ],
      ),
    ));
  }
}
