import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/group.dart';
import 'package:flutter_chat/common/entities/groupUsers.dart';
import 'package:flutter_chat/common/entities/names.dart';
import 'package:flutter_chat/common/entities/userGroups.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/widgets/toast.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/group/createGroup/state.dart';
import 'package:get/get.dart';

class CreateGroupController extends GetxController {
  CreateGroupController();
  CreateGroupState state = CreateGroupState();

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
      print("group created");
      var addedgroup = await db
          .collection(Entity.group)
          .withConverter(
              fromFirestore: Group.fromFirestore,
              toFirestore: (Group group, options) => group.toFirestore())
          .add(group);
      print("group added");

      UserGroups userGroups = UserGroups(groupId: addedgroup.id);
      await db
          .collection(Entity.users)
          .doc(userid)
          .collection(Entity.groupList)
          .add({"groupId": userGroups.groupId});
      print("group added to user");

      GroupUsers groupUsers = GroupUsers(userId: userid, isAdmin: true);
      await db
          .collection(Entity.group)
          .doc(addedgroup.id)
          .collection(Entity.groupUsers)
          .withConverter(
              fromFirestore: GroupUsers.fromFirestore,
              toFirestore: (GroupUsers groupUsers, options) =>
                  groupUsers.toFirestore())
          .add(groupUsers);
      await Get.toNamed(
        AppRoutes.GROUPCHAT,
        parameters: {
          "groupId": addedgroup.id,
          "grouName": groupNameController.text,
          "groupAdmin": userid,
          "groupAvatar": group.avatar ?? "",
        },
      );
      print("group routed");
      toastInfo(msg: "successfully created");
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
