import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/insta/detailofuser.dart';
import 'package:ui/insta/upload.dart';

import '../classModel/UsersModel.dart';
import '../juiceHub/data.dart';
import 'followingList.dart';

class followList extends StatefulWidget {
  const followList({Key? key}) : super(key: key);

  @override
  State<followList> createState() => _followListState();
}

class _followListState extends State<followList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      MaterialPageRoute(builder: (context) => FollowingList()));
                },
                child: Text('following'),
              ),
            ),
            body: Container(
                child: StreamBuilder<UsersModel>(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(currentUserId)
                        .snapshots()
                        .map((event) => UsersModel.fromJson(event.data()!)),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final data = snapshot.data;
                      return ListView.builder(
                          itemCount: data!.follow!.length,
                          itemBuilder: (context, index) {
                            final userId = data.follow![index];

                            return StreamBuilder<UsersModel>(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(userId)
                                    .snapshots()
                                    .map((event) =>
                                        UsersModel.fromJson(event.data()!)),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData || snapshot.hasError) {
                                    return CircularProgressIndicator();
                                  }
                                  final user = snapshot.data;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    child: ListTile(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      trailing: Container(
                                        child: (user!.profile == null)
                                            ? CircleAvatar(
                                                radius: 20,
                                                child: Icon(Icons.person),
                                              )
                                            : CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    user.profile.toString())),
                                      ),

                                      subtitle: Column(
                                        children: [
                                          Text(
                                            user.name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(user.email.toString()),
                                          Text(user.phone.toString()),
                                          Text(user.uid.toString()),
                                          SizedBox(
                                            height: 9,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 80),
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
                                                  if (user.follow!.contains(
                                                      currentUserId)) {
                                                    user.reference!.update({
                                                      'follow': FieldValue
                                                          .arrayRemove(
                                                              [currentUserId]),
                                                    });
                                                  } else {
                                                    user.reference!.update({
                                                      'follow':
                                                          FieldValue.arrayUnion(
                                                              [currentUserId]),
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors
                                                      .transparent, // Make the ElevatedButton transparent
                                                  shadowColor: Colors
                                                      .transparent, // Remove the shadow
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // Match the container's borderRadius
                                                  ),
                                                ),
                                                child: Text(
                                                  (user.follow!.contains(
                                                          currentUserId))
                                                      ? 'follow Back'
                                                      : 'following',
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing: Container(
                                      //   height: 20,
                                      //   width: 20,
                                      //   child: Center(
                                      //     child: TextButton(
                                      //         style: ButtonStyle(
                                      //           backgroundColor:
                                      //               MaterialStateProperty.all(
                                      //                   Colors.white),
                                      //         ),
                                      //         onPressed: () {
                                      //           if (data.follow!
                                      //               .contains(currentUserId)) {
                                      //             user.reference!.update({
                                      //               'follow':
                                      //                   FieldValue.arrayRemove(
                                      //                       [currentUserId]),
                                      //             });
                                      //           } else {
                                      //             user.reference!.update({
                                      //               'follow':
                                      //                   FieldValue.arrayUnion(
                                      //                       [currentUserId]),
                                      //             });
                                      //           }
                                      //         },
                                      //         child: (user.follow!
                                      //                 .contains(currentUserId))
                                      //             ? Text("UNFOLLOW",
                                      //                 style: TextStyle(
                                      //                     color: Colors.black))
                                      //             : Text("FOLLOW",
                                      //                 style: TextStyle(
                                      //                     color:
                                      //                         Colors.black))),
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.transparent,
                                      //     borderRadius:
                                      //         BorderRadius.circular(30),
                                      //     border:
                                      //         Border.all(color: Colors.black),
                                      //   ),
                                      // ),
                                    ),
                                  );
                                });
                          });
                    }))));
  }
}

//
// return ListView.builder(
// itemCount: data!.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.only(
// top: 10, right: 15, left: 15),
// child: Container(
// // height: 150,
// width: double.infinity,
// decoration: BoxDecoration(
// color: Colors.transparent,
// border: Border.all(color: Colors.black, width: 2),
// borderRadius:
// BorderRadius.all(Radius.circular(20)),
// ),
// child: ListTile(
// trailing: Container(
// height: 100,
// width: 35,
// child: (data[index].profile == null)
// ? CircleAvatar(
// radius: 35,
// backgroundImage:
// AssetImage("assets/images/dew.png"),
// )
//     : CircleAvatar(
// backgroundImage: NetworkImage(
// data[index].profile.toString()),
// ),
// ),
// title: Text(data[index].name.toString()),
// subtitle: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(data[index].email.toString()),
// Text(data[index].email.toString()),
// Text(data[index].uid.toString()),
// SizedBox(height: 9),
// Padding(
// padding: const EdgeInsets.only(right: 80),
// child: Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// Colors.purple,
// Colors.blueAccent
// ],
// begin: Alignment.bottomLeft,
// end: Alignment.topRight,
// stops: [0.4, 0.7],
// tileMode: TileMode.repeated,
// ),
// borderRadius: BorderRadius.circular(
// 10), // You can adjust the radius as needed
// ),
// child: ElevatedButton(
// onPressed: () {
// if (data[index]
//     .follow!
//     .contains(currentUserId)) {
// data[index].reference!.update({
// 'follow': FieldValue.arrayRemove(
// [currentUserId]),
// });
// } else {
// data[index].reference!.update({
// 'follow': FieldValue.arrayUnion(
// [currentUserId]),
// });
// }
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.transparent,
// // Make the ElevatedButton transparent
// shadowColor: Colors.transparent,
// // Remove the shadow
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(
// 10), // Match the container's borderRadius
// ),
// ),
// child: Text(
// (data[index]
//     .follow!
//     .contains(currentUserId))
// ? 'Following'
//     : 'Follow',
// ),
// ),
// ),
// )
// ],
// ),
// ),
// ),
// );
// }
// })}
