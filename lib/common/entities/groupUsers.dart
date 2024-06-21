import 'package:cloud_firestore/cloud_firestore.dart';

class GroupUsers {
  final String? id;
  final String? userId;
  final bool? isAdmin;
  GroupUsers({this.id, this.userId, this.isAdmin});

  factory GroupUsers.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return GroupUsers(
      id: data?["id"],
      userId: data?["groupId"],
      isAdmin: data?["isAdmin"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (userId != null) "groupId": userId,
      if (isAdmin != null) "isAdmin": isAdmin,
    };
  }
}
