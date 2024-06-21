import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat/common/entities/message.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/message/state.dart';
import 'package:get/get.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageController extends GetxController {
  MessageController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  final MessageState state = MessageState();
  bool isEmojiVisible = false;
  var listener;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() {
    asyncLoadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    });
  }

  void onLoading() {
    asyncLoadAllData().then((_) {
      refreshController.loadComplete();
    });
  }

  asyncLoadAllData() async {
    try {
      var fromMessage = await db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .where("from_uid", isEqualTo: token)
          .get();

      var toMessage = await db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .where("to_uid", isEqualTo: token)
          .get();
      state.msgList.clear();
      if (fromMessage.docs.isNotEmpty) {
        state.msgList.addAll(fromMessage.docs);
      }

      if (toMessage.docs.isNotEmpty) {
        state.msgList.addAll(toMessage.docs);
      }
    } catch (e) {
      if (kDebugMode) {
        print("loadmessages has error ${e.toString()}");
      }
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
}
