import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat/common/entities/group.dart';
import 'package:flutter_chat/common/entities/userGroups.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/group/state.dart';
import 'package:get/get.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:firebase_messaging/firebase_messaging.dart';

class GroupController extends GetxController {
  GroupController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  final GroupState state = GroupState();
  bool isEmojiVisible = false;
  var listener;

  final RefreshController groupRefreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() {
    asyncLoadAllData().then((_) {
      groupRefreshController.refreshCompleted(resetFooterState: true);
    });
  }

  void onLoading() {
    asyncLoadAllData().then((_) {
      groupRefreshController.loadComplete();
    });
  }

  asyncLoadAllData() async {
    try {
      var groupIds = await db
          .collection("users")
          .doc(token)
          .collection("groupList")
          .withConverter(
              fromFirestore: UserGroups.fromFirestore,
              toFirestore: (UserGroups userGroups, options) =>
                  userGroups.toFirestore())
          .get();
      List<String?> ids = [];
      for (var doc in groupIds.docs) {
        ids.add(doc.data().groupId!);
      }
      if (kDebugMode) {
        print("Group id is ${ids.first}");
      }
      List<Group> g = [];
      for (String? id in ids) {
        var groups = await db
            .collection("group")
            .doc(id)
            .withConverter(
                fromFirestore: Group.fromFirestore,
                toFirestore: (Group g, options) => g.toFirestore())
            .get();

        if (groups.data() != null) {
          Group group = Group(
              id: id,
              adminId: groups.data()!.adminId,
              avatar: groups.data()!.avatar,
              last_msg: groups.data()!.last_msg,
              name: groups.data()!.name,
              last_time: groups.data()!.last_time);
          print(group.adminId);
          g.add(group);
          print(g.first.id);
        }
        state.msgList.assignAll(g);
      }
    } catch (e) {
      print("loadmessages has error $e");
    }
  }

  getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      var user =
          await db.collection("users").where("id", isEqualTo: token).get();
      if (user.docs.isNotEmpty) {
        var docId = user.docs.first.id;
        await db.collection('users').doc(docId).update({'fcmtoken': fcmToken});
      }
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   //getFcmToken();
  // }
  @override
  void dispose() {
    groupRefreshController.dispose();
    super.dispose();
  }
}
