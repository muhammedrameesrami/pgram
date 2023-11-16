import 'package:cloud_firestore/cloud_firestore.dart';

import '../insta/detailofuser.dart';

UsersModel? usersModel;

class UsersModel {
  String? uid; // Change Uid to uid
  String? email;
  String? name;
  String? profile;
  String? phone;
  Timestamp? createdDate;
  Timestamp? loginDate;
  List? follow;
  String? password;
  DocumentReference? reference;

  UsersModel.defaul();

  UsersModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profile,
    required this.phone,
    required this.createdDate,
    required this.loginDate,
    required this.follow,
    required this.password,
    this.reference,
  });

  UsersModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"],
        profile = json["profile"],
        phone = json["phone"],
        loginDate = json["loginDate"],
        createdDate = json["createdDate"],
        uid = json["uid"],
        follow = json['follow'],
        reference = json["reference"],
        password = json['password'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["email"] = email;
    data["profile"] = profile;
    data["phone"] = phone;
    data["loginDate"] = loginDate;
    data['createdDate'] = createdDate;
    data['uid'] = uid;
    data['follow'] = follow;
    data["reference"] = reference;
    data['password'] = password;

    return data;
  }

  UsersModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? profile,
    String? phone,
    String? password,
    List? follow,
    Timestamp? createdDate,
    Timestamp? loginDate,
    DocumentReference? reference,
  }) =>
      UsersModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        profile: profile ?? this.profile,
        phone: phone ?? this.phone,
        follow: follow ?? this.follow,
        createdDate: createdDate ?? this.createdDate,
        loginDate: loginDate ?? this.loginDate,
        password: '',
        reference: reference ?? this.reference,
      );
}

//to fetch data in firebase users without i

Stream<List<UsersModel>> user() {
  return FirebaseFirestore.instance
      .collection('user')
      .where('uid', isNotEqualTo: currentUserId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UsersModel.fromJson(doc.data())).toList());
}
