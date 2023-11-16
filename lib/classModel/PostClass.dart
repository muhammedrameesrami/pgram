import 'package:cloud_firestore/cloud_firestore.dart';

class PostClass {
  String? postName;
  String? uid;
  Timestamp? uploadTime;
  List? likes;
  DocumentReference? reference;
  String? pid;

  PostClass(
      {required this.postName,
      required this.uid,
      required this.uploadTime,
      this.likes,
      this.pid,
      this.reference});
  Map<String, dynamic> toJson() {
    return {
      'postName': postName,
      'uid': uid,
      'uploadTime': uploadTime,
      'likes': likes,
      'pid': pid,
      'reference': reference,
    };
  }

  PostClass.fromJson(Map<String, dynamic> map) {
    postName = map['postName'];
    uid = map['uid'];
    uploadTime = map['uploadTime'];
    likes = map['likes'];
    pid = map['pid'];
    reference = map['reference'];
  }
  PostClass copyWith(
      {String? postName,
      String? uid,
      String? pid,
      Timestamp? uploadTime,
      List? likes,
      DocumentReference? reference}) {
    return PostClass(
      postName: postName ?? this.postName,
      uid: uid ?? this.uid,
      uploadTime: uploadTime ?? this.uploadTime,
      likes: likes ?? this.likes,
      pid: pid ?? this.pid,
      reference: reference ?? this.reference,
    );
  }
}

// to fetch firebase subcollection post class
Stream<List<PostClass>> alluser() {
  return FirebaseFirestore.instance.collectionGroup('post').snapshots().map(
      (event) => event.docs.map((e) => PostClass.fromJson(e.data())).toList());
}
