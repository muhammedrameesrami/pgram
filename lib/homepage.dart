import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/juiceHub/data.dart';
import 'package:ui/juiceHub/shake.dart';
import 'package:ui/Auth/signup.dart';
import 'package:ui/juiceHub/smoothi.dart';
import 'package:ui/juiceHub/coffee.dart';
import 'package:ui/insta/upload.dart';
import 'classModel/UsersModel.dart';
import 'juiceHub/data.dart';

import 'juiceHub/cocktail.dart';
import 'insta/detailofuser.dart';
import 'juiceHub/mocktail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getMyProfile() {
    //to get my user id
    FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserId)
        .get()
        .then((value) {
      myProfile = value.data()!;
      myPro = UsersModel.fromJson(myProfile);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProfile();
  }

  var height;
  var width;
  var s = "Shakes";
  @override
  Widget build(BuildContext context) {
    // print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    // print(getMyProfile());
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.brown.shade700,
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Juice Hub!",
                          style: TextStyle(
                              fontSize: width * 0.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Upload()));
                          },
                          child: Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade100.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.black,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            signout(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                  height: height * 0.05,
                                  width: width * 0.1,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.red.shade100.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 250, left: 10),
                    child: Text(
                      s,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: width * 1,
                      height: height * 0.1,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,
                                color: Colors.black, size: 30),
                            hintText: 'Search',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              height: height * 0.1,
                              width: width * 1,
                              child: TabBar(
                                unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                                indicatorColor: Colors.grey,
                                tabs: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        s = 'Cocktail';
                                      });
                                    },
                                    child: Tab(
                                      text: "Cocktail",
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          s = 'Mocktail';
                                        });
                                      },
                                      child: Tab(text: "Mocktail")),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          s = 'Coffee';
                                        });
                                      },
                                      child: Tab(text: "Coffee")),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          s = 'Shakes';
                                        });
                                      },
                                      child: Tab(text: "Shakes")),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.685,
                          width: width * 0.7,
                          child: TabBarView(
                            children: [
                              coktail(
                                cocktailItems: cocktailItem,
                              ),
                              mocktail(mocktailItems: mocktailItems),
                              coffee(coffeeitems: coffeeitem),
                              tabview(shakeitems: shakeitem),
                            ],
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

signout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('uid');
  GoogleSignIn().signOut().then((value) => Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => signup()), (route) => false));
}
