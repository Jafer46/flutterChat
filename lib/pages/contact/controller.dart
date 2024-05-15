import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/common/entities/message.dart';
import 'package:flutter_chat/common/entities/userData.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/contact/index.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  ContactController();

  final ContactState state = ContactState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goToChat(UserData toUserData) async {
    var fromMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: toUserData.id)
        .get();
    var toMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: toUserData.id)
        .where("to_uid", isEqualTo: token)
        .get();

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();

      UserLoginResponseEntity userdata =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));

      var msgdata = Msg(
          from_uid: userdata.accessToken,
          to_uid: toUserData.id,
          from_name: userdata.displayName,
          to_name: toUserData.name,
          from_avatar: userdata.photoUrl,
          to_avatar: toUserData.photourl,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);

      db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgdata)
          .then((value) {
        Get.toNamed(AppRoutes.CHAT, parameters: {
          "doc_id": value.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avata": toUserData.photourl ?? "",
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed(AppRoutes.CHAT, parameters: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avata": toUserData.photourl ?? "",
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Get.toNamed(AppRoutes.CHAT, parameters: {
          "doc_id": toMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avata": toUserData.photourl ?? "",
        });
      }
    }
  }

  asyncLoadAllData() async {
    var userBase = await db
        .collection("users")
        //.where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore())
        .get();

    for (var doc in userBase.docs) {
      UserData userData = doc.data();
      userData.id = doc.id;
      state.contactList.add(userData);
    }
  }
}
