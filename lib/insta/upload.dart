import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:ui/classModel/comentModel.dart';
import 'package:ui/insta/new.dart';
import 'package:ui/insta/postPage.dart';
import '../classModel/PostClass.dart';
import '../classModel/UsersModel.dart';
import 'detailofuser.dart';
import 'edit.dart';
import 'followList.dart';
import 'followingList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

UsersModel myPro = UsersModel.defaul();
String? followersLength;
String? followingLength;

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController commentController = TextEditingController();
  late Future<void> launched;
  Future<void> _launchedInWebViewOrVc(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        forceSafariVC: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getFollowers() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(myPro.uid)
        .get();
  }

  getfollowing() async {
    await FirebaseFirestore.instance
        .collection('user')
        .where(['follow'], arrayContains: myPro.uid)
        .get()
        .then((value) {
          followingLength = value.size.toString();
        });
  }

  addComment(
      {required String pid, required String comment, required String uid}) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('post')
        .doc(pid)
        .collection('comment')
        .add({
      'comment': comment,
      'commentUploadTime': FieldValue.serverTimestamp(),
      'commentLikes': [],
      'replyComments': [],
      'uid': myPro.uid,
    }).then((value) {
      value.update({
        'cid': value.id,
        'reference': value,
      });
    });
  }

  @override
  void initState() {
    getFollowers();
    getfollowing();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.blueAccent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50), // Adjust the curve here
            bottomRight: Radius.elliptical(200, 220), // Adjust the curve here
          ),
        ),

        //drawer section
        height: double.infinity,
        width: 250,

        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            (CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(myPro.profile.toString()),
            )),
            SizedBox(
              height: 15,
            ),
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Edit()));
                  setState(() {});
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 35,
                )),
            Text(
              myPro.name.toString(),
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              myPro.email.toString(),
              style: TextStyle(fontSize: 20, color: Colors.white54),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => followList()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // minimumSize: Size(0, 0),
                    alignment: Alignment.center,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        'Follow',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowingList()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size(0, 0),
                    alignment: Alignment.center,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: Text(
                        'Following',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailOfUser()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size(0, 0),
                    alignment: Alignment.center,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: Text(
                        'user',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent), // Make the ElevatedButton transparent
                shadowColor: MaterialStateProperty.all<Color>(
                    Colors.transparent), // Remove the shadow
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => postPage()));
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
                    'My Post',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18), // Customize the text style
                  ),
                ),
              ),
            ),
          ],
        ),
        //drawer section
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.4, 0.7],
                tileMode: TileMode.repeated,
              ),
            ),
            child: Row(
              children: [
                Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.only(left: 20, top: 35),
                    child: IconButton(
                      icon: Icon(Icons.menu,
                          color: Colors
                              .white), // Replace 'menu' with the appropriate drawer icon
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 50),
                  child: Text("Instagram",
                      style: GoogleFonts.lobster(
                          fontSize: 35, color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<PostClass>>(
                stream: alluser(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                    // Handle cases where there's no data
                  }
                  var data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<UsersModel>(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(data[index].uid)
                                .snapshots()
                                .map((event) =>
                                    UsersModel.fromJson(event.data()!)),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text('No data available.');

                                // Handle cases where there's no data
                              } else {
                                UsersModel? puser = snapshot.data;
                                return Column(
                                  children: [
                                    FlipCard(
                                      direction: FlipDirection.HORIZONTAL,
                                      // front of the card
                                      front: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, top: 4),
                                                  child: Container(
                                                      child: CircleAvatar(
                                                          radius: 25,
                                                          backgroundImage:
                                                              NetworkImage(puser!
                                                                  .profile
                                                                  .toString()))),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    puser.name.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: InkWell(
                                                  onDoubleTap: () {
                                                    if (data[index]
                                                        .likes!
                                                        .contains(myPro.uid)) {
                                                      data[index]
                                                          .likes!
                                                          .remove(myPro.uid);
                                                      data[index] = data[index]
                                                          .copyWith(
                                                              likes: data[index]
                                                                  .likes);
                                                      data[index]
                                                          .reference!
                                                          .update(data[index]
                                                              .toJson());
                                                    } else {
                                                      data[index]
                                                          .likes!
                                                          .add(myPro.uid);
                                                      data[index] = data[index]
                                                          .copyWith(
                                                              likes: data[index]
                                                                  .likes);
                                                      data[index]
                                                          .reference!
                                                          .update(data[index]
                                                              .toJson());
                                                    }
                                                  },
                                                  child: Image.network(
                                                    data[index]
                                                        .postName
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 5),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (data[index]
                                                          .likes!
                                                          .contains(
                                                              myPro.uid)) {
                                                        data[index]
                                                            .likes!
                                                            .remove(myPro.uid);
                                                        data[index] = data[
                                                                index]
                                                            .copyWith(
                                                                likes:
                                                                    data[index]
                                                                        .likes);
                                                        data[index]
                                                            .reference!
                                                            .update(data[index]
                                                                .toJson());
                                                      } else {
                                                        data[index]
                                                            .likes!
                                                            .add(myPro.uid);
                                                        data[index] = data[
                                                                index]
                                                            .copyWith(
                                                                likes:
                                                                    data[index]
                                                                        .likes);
                                                        data[index]
                                                            .reference!
                                                            .update(data[index]
                                                                .toJson());
                                                      }
                                                    },
                                                    icon: (data[index]
                                                            .likes!
                                                            .contains(
                                                                myPro.uid))
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 25,
                                                          )
                                                        : Icon(
                                                            Icons.favorite,
                                                            color: Colors.white,
                                                            size: 25,
                                                          ),
                                                  ),
                                                ),
                                                Text(
                                                  data[index]
                                                      .likes!
                                                      .length
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 5),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StreamBuilder<
                                                              List<
                                                                  CommentModel>>(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'user')
                                                                .doc(data[index]
                                                                    .uid)
                                                                .collection(
                                                                    'post')
                                                                .doc(data[index]
                                                                    .pid)
                                                                .collection(
                                                                    'comment')
                                                                .snapshots()
                                                                .map((event) => event
                                                                    .docs
                                                                    .map((e) =>
                                                                        CommentModel.fromJson(
                                                                            e.data()))
                                                                    .toList()),
                                                            builder: (context,
                                                                snapshot) {
                                                              var comments =
                                                                  snapshot.data ??
                                                                      [];
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Text(
                                                                    'No data');
                                                              }
                                                              return Column(
                                                                children: [
                                                                  // Add a centered text at the top
                                                                  Center(
                                                                    child: Text(
                                                                      'Comments',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount:
                                                                          comments
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        var userComment =
                                                                            comments[index];
                                                                        return StreamBuilder(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection('user')
                                                                              .doc(userComment.uid)
                                                                              .snapshots()
                                                                              .map((event) => UsersModel.fromJson(event.data()!)),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            var userData =
                                                                                snapshot.data;
                                                                            if (snapshot.hasData) {
                                                                              return Container(
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        ClipOval(
                                                                                          child: Container(
                                                                                            height: 30,
                                                                                            width: 30,
                                                                                            child: (userData!.profile == null || userData.profile == '')
                                                                                                ? Icon(Icons.person)
                                                                                                : Image.network(
                                                                                                    userData.profile.toString(),
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(userData.name ?? '')
                                                                                      ],
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 30, top: 5),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(userComment.comment ?? ''),
                                                                                          Icon(Icons.favorite_border)
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 70),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text('reply ')
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              return Text('Error');
                                                                            }
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  // Add a text form field at the bottom
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          commentController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Add your comment...',
                                                                        suffixIcon: IconButton(
                                                                            icon: Icon(Icons.send),
                                                                            onPressed: () {
                                                                              try {
                                                                                addComment(uid: data[index].uid!, pid: data[index].pid!, comment: commentController.text);
                                                                                print('comment added');
                                                                              } catch (e) {
                                                                                print('eror in comment$e');
                                                                              }
                                                                            } // Handl]e comment submission here
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.comment,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 5),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        launched =
                                                            _launchedInWebViewOrVc(
                                                                'https://www.instagram.com');
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Colors.white,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      // back of the card
                                      back: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),

                                        alignment: Alignment.center,
                                        // width: 200,
                                        // height: 350,
                                        child: Column(
                                          children: [
                                            StreamBuilder<UsersModel>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('user')
                                                    .doc(data[index].uid)
                                                    .snapshots()
                                                    .map((event) =>
                                                        UsersModel.fromJson(
                                                            event.data()!)),
                                                builder: (context, snapshot) {
                                                  var data = snapshot.data!;
                                                  return Container(
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage:
                                                                NetworkImage(data
                                                                    .profile
                                                                    .toString()),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              FollowingList()));
                                                            },
                                                            child: Container(
                                                                child:
                                                                    FutureBuilder(
                                                              future:
                                                                  getFollowers(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Text(
                                                                  'Followers $followersLength',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                );
                                                              },
                                                            )),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              followList()));
                                                            },
                                                            child: Container(
                                                              child:
                                                                  FutureBuilder(
                                                                      future:
                                                                          getfollowing(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        return Text(
                                                                          'following $followingLength',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.white),
                                                                        );
                                                                      }),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                            Container(
                                              color: Colors.white,
                                              height: 400,
                                              child: StreamBuilder<
                                                      List<PostClass>>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('user')
                                                      .doc(data[index].uid)
                                                      .collection('post')
                                                      .snapshots()
                                                      .map((event) => event.docs
                                                          .map((e) => PostClass
                                                              .fromJson(
                                                                  e.data()!))
                                                          .toList()),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Text(
                                                          'No data available.');

                                                      // Handle cases where there's no data
                                                    } else {
                                                      List<PostClass>?
                                                          postData =
                                                          snapshot.data;
                                                      return GridView.builder(
                                                          itemBuilder:
                                                              (context, i) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Image(
                                                                  image: NetworkImage(
                                                                      postData![
                                                                              i]
                                                                          .postName
                                                                          .toString())),
                                                            );
                                                          },
                                                          itemCount:
                                                              postData!.length,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                          ));
                                                    }
                                                  }),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.blueGrey),
                                              height: 50,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
