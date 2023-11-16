import 'package:cloud_firestore/cloud_firestore.dart';

CommentModel? comentobj;

class CommentModel {
  String? cid;
  String? comment;
  List? commentLikes;
  Timestamp? commentUploadTime;
  String? pid;
  DocumentReference? reference;
  List? replyComments;
  String? uid;

  CommentModel(
      {required this.cid,
      required this.comment,
      required this.commentLikes,
      required this.commentUploadTime,
      required this.pid,
      required this.reference,
      required this.replyComments,
      required this.uid});
  Map<String, dynamic> toJson() {
    return {
      'cid': cid,
      'comment': comment,
      'commentLikes': commentLikes,
      'commentUploadTime': commentUploadTime,
      'pid': pid,
      'reference': reference,
      'replyComments': replyComments,
      'uid': uid,
    };
  }

  CommentModel.fromJson(Map<String, dynamic> m) {
    cid = m['cid'];
    comment = m['comment'];
    commentLikes = m['commentLikes'] ?? [];
    commentUploadTime = m['commentUploadTime'];
    pid = m['pid'];
    reference = m['reference'];
    replyComments = m['replyComments'] ?? [];
    uid = m['uid'];
  }
  CommentModel copyWith(
          {String? cid,
          String? comment,
          List? commentLikes,
          Timestamp? commentUploadTime,
          String? pid,
          DocumentReference? reference,
          List? replyComments,
          String? uid}) =>
      CommentModel(
          cid: cid ?? this.cid,
          comment: comment ?? this.comment,
          commentLikes: commentLikes ?? this.commentLikes,
          commentUploadTime: commentUploadTime ?? this.commentUploadTime,
          pid: pid ?? this.pid,
          reference: reference ?? this.reference,
          replyComments: replyComments ?? this.replyComments,
          uid: uid ?? this.uid);
}
