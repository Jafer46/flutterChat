import 'package:cloud_firestore/cloud_firestore.dart';

class UserGroups {
  final String? id;
  final String? groupId;
  UserGroups({this.id, this.groupId});

  factory UserGroups.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserGroups(
      id: data?["id"],
      groupId: data?["groupId"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (groupId != null) "groupId": groupId,
    };
  }
}
