import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String? id;
  final String? name;
  String? avatar;
  final String? adminId;
  final String? last_msg;
  final Timestamp? last_time;
  final int? msg_num;

  Group({
    this.adminId,
    this.last_msg,
    this.last_time,
    this.msg_num,
    this.avatar,
    this.name,
    this.id,
  });

  factory Group.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Group(
      adminId: data?['adminId'],
      last_msg: data?['last_msg'],
      last_time: data?['last_time'],
      msg_num: data?['msg_num'],
      avatar: data?['avatar'],
      name: data?['name'],
      id: data?['id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return ({
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (adminId != null) "adminId": adminId,
      if (last_msg != null) "last_msg": last_msg,
      if (last_time != null) "last_time": last_time,
    });
  }
}
