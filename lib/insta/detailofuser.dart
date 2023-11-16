import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/insta/upload.dart';
import '../classModel/UsersModel.dart';

String currentUserId = '';
Map<String, dynamic> myProfile = {};

class DetailOfUser extends StatefulWidget {
  const DetailOfUser({Key? key}) : super(key: key);

  @override
  State<DetailOfUser> createState() => _DetailOfUserState();
}

class _DetailOfUserState extends State<DetailOfUser> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    print('[][][][][][][][][][][][][][][][][][][][][][][][][');
    print(myPro.uid);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.blueAccent
                  ], // Customize the gradient colors
                  begin: Alignment
                      .centerLeft, // Customize the starting point of the gradient
                  end: Alignment
                      .centerRight, // Customize the ending point of the gradient
                ),
              ),
            ),
            title: TextFormField(
              controller: _searchController,
              onChanged: (text) {
                print("object--");
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                suffixIcon: InkWell(
                  // onTap: () {
                  //   setState(() {
                  //     _searchController.clear();
                  //   });
                  // },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                hintText: 'Search',
                fillColor: Colors.white,
                border: InputBorder.none,
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            color: Colors.transparent,
            width: 400,
            child: StreamBuilder<List<UsersModel>>(
              stream: user(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text('No users found.'),
                  );
                } else {
                  var data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      UsersModel user = data[index];
                      if (_searchController.text.isEmpty ||
                          user.name!
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 15),
                          child: Container(
                            // height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ListTile(
                              trailing: Container(
                                height: 100,
                                width: 35,
                                child: (user.profile == null)
                                    ? CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage("assets/images/dew.png"),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            user.profile.toString()),
                                      ),
                              ),
                              title: Text(user.name.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.email.toString()),
                                  Text("phone : ${user.phone ?? ''}"),
                                  Text("UId : ${user.uid.toString()}"),
                                  SizedBox(height: 9),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (data[index]
                                            .follow!
                                            .contains(myPro.uid)) {
                                          user.follow!.remove(myPro.uid);
                                          data[index] = data[index].copyWith(
                                              follow: data[index].follow);
                                          user.reference!
                                              .update(data[index].toJson());

                                          // data[index]
                                          //     .reference!
                                          //     .update(data[index].toJson());
                                        } else {
                                          data[index].follow!.add(myPro.uid);
                                          data[index] = data[index].copyWith(
                                              follow: data[index].follow);
                                          FirebaseFirestore.instance
                                              .collection('user')
                                              .doc(data[index].uid)
                                              .update(data[index].toJson());
                                          // data[index]
                                          //     .reference!
                                          //     .update(data[index].toJson());
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .transparent, // Make the ElevatedButton transparent
                                        shadowColor: Colors
                                            .transparent, // Remove the shadow
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Match the container's borderRadius
                                        ),
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.purple,
                                              Colors.blueAccent,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Text(
                                            (data[index]
                                                    .follow!
                                                    .contains(myPro.uid))
                                                ? 'Following'
                                                : 'Follow',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

test() {
  FirebaseFirestore.instance
      .collection('settings')
      .doc('ramees')
      .update({"test.mark": FieldValue.delete()});
}
