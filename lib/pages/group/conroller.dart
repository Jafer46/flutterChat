import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/group.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/widgets/toast.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/group/state.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  GroupController();
  GroupState state = GroupState();

  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  final userid = UserStore.to.token;
  GlobalKey<FormState> formState = GlobalKey();
  var groupNameController = TextEditingController();

  void createGroup() async {
    Group group = Group(
      adminId: userid,
      avatar: null,
      last_msg: null,
      name: groupNameController.text,
      last_time: Timestamp.now(),
    );
    try {
      var addedgroup = await db
          .collection("group")
          .withConverter(
              fromFirestore: Group.fromFirestore,
              toFirestore: (Group group, options) => group.toFirestore())
          .add(group);

      db
          .collection("users")
          .doc(userid)
          .collection("groupList")
          .add({"goupId": addedgroup.id});

      toastInfo(msg: "successfully created");
      Get.toNamed(AppRoutes.GROUPCHAT, parameters: {
        "groupId": addedgroup.id,
        "grouName": groupNameController.text,
        "groupAdmin": group.adminId!,
        "groupAvatar": group.avatar!,
      });
    } catch (e) {
      toastInfo(msg: "group was not created!");
    }
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }
}
