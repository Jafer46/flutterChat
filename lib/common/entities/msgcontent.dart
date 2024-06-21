import 'package:cloud_firestore/cloud_firestore.dart';

class Msgcontent {
  String? id;
  String? uid;
  String? content;
  String? type;
  String? senderName;
  String? senderAvatar;
  Timestamp? addtime;

  Msgcontent(
      {this.id,
      this.uid,
      this.content,
      this.type,
      this.addtime,
      this.senderAvatar,
      this.senderName});

  factory Msgcontent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Msgcontent(
      id: data?['id'],
      uid: data?['uid'],
      content: data?['content'],
      type: data?['type'],
      senderName: data?['senderName'],
      senderAvatar: data?['senderAvatar'],
      addtime: data?['addtime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (uid != null) "uid": uid,
      if (content != null) "content": content,
      if (type != null) "type": type,
      if (senderName != null) "senderName": senderName,
      if (senderAvatar != null) "senderAvatar": senderAvatar,
      if (addtime != null) "addtime": addtime,
    };
  }
}
