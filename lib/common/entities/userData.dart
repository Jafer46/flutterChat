import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? id;
  final String? name;
  final String? email;
  String? photourl;
  final String? fcmtoken;
  final Timestamp? addTime;
  bool? isOnline;

  UserData({
    this.id,
    this.email,
    this.fcmtoken,
    this.name,
    this.photourl,
    this.addTime,
    this.isOnline,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
      photourl: data?['photurl'],
      fcmtoken: data?['fcmtoken'],
      addTime: data?['addtime'],
      isOnline: data?['isOnline'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (photourl != null) "photourl": photourl,
      if (fcmtoken != null) "fcmtoken": fcmtoken,
      if (addTime != null) "addTime": addTime,
      if (isOnline != null) "isOnline": isOnline,
    };
  }
}
