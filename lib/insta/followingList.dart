import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classModel/UsersModel.dart';
import '../juiceHub/data.dart';
import 'detailofuser.dart';
import 'followList.dart';

List myFollowers = [];

class FollowingList extends StatefulWidget {
  const FollowingList({Key? key}) : super(key: key);

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  UsersModel? myPro;

  //follow and use the functoin in the stream here i do when my user id contain their arry and show that
  Stream<List<UsersModel>> follow() {
    return FirebaseFirestore.instance
        .collection('user')
        .where('follow', arrayContains: currentUserId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UsersModel.fromJson(e.data())).toList());
  }

  @override
  void initState() {
    follow();
    print(follow());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
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
            title: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => followList()));
              },
              child: Text('follow'),
            ),
          ),
          body: Container(
            height: double.infinity,
            color: Colors.transparent,
            width: 400,
            child: StreamBuilder<List<UsersModel>>(
              stream: follow(),
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
                      var user = data[index];
                      if (user.follow!.contains(currentUserId)) {
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.purple,
                                            Colors.blueAccent
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          stops: [0.4, 0.7],
                                          tileMode: TileMode.repeated,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10), // You can adjust the radius as needed
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print(currentUserId);
                                          if (data[index]
                                              .follow!
                                              .contains(currentUserId)) {
                                            data[index]
                                                .follow!
                                                .remove(currentUserId);
                                            data[index] = data[index].copyWith(
                                                follow: data[index].follow);
                                            FirebaseFirestore.instance
                                                .collection('user')
                                                .doc(data[index].uid)
                                                .update(data[index].toJson());

                                            // data[index]
                                            //     .reference!
                                            //     .update(data[index].toJson());
                                          } else {
                                            // data[index].follow!.add(myPro.uid);
                                            // data[index] = data[index].copyWith(
                                            //     follow: data[index].follow);
                                            // FirebaseFirestore.instance
                                            //     .collection('user')
                                            //     .doc(data[index].uid)
                                            //     .update(data[index].toJson());

                                            // data[index]
                                            //     .reference!
                                            //     .update(data[index].toJson());
                                          }
                                          // if (user.follow!
                                          //     .contains(currentUserId)) {
                                          //   user.reference!.update({
                                          //     'follow': FieldValue.arrayRemove(
                                          //         [currentUserId]),
                                          //   });
                                          // } else {
                                          //   user.reference!.update({
                                          //     'follow': FieldValue.arrayUnion(
                                          //         [currentUserId]),
                                          //   });
                                          // }
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
                                        child: Text(
                                          (user.follow!.contains(currentUserId))
                                              ? 'unfollow'
                                              : 'Follow',
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
