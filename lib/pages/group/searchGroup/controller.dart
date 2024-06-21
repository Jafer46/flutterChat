import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/group.dart';
import 'package:flutter_chat/common/entities/names.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/group/searchGroup/index.dart';
import 'package:get/get.dart';

class SearchGroupController extends GetxController {
  SearchGroupController();

  final SearchGroupState state = SearchGroupState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  final TextEditingController searchController = TextEditingController();

  // @override
  // void onReady() {
  //   super.onReady();
  //   asyncLoadAllData();
  // }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchChats();
    });
  }

  void searchChats() async {
    state.searchList.clear();
    if (searchController.text == "") {
      return;
    }

    Set<String?> uniqueIds = {};
    var users = await db
        .collection(Entity.group)
        .withConverter(
            fromFirestore: Group.fromFirestore,
            toFirestore: (Group group, options) => group.toFirestore())
        .where("name", isGreaterThanOrEqualTo: searchController.text)
        .where("name", isLessThan: "${searchController.text}\uf8ff")
        .get();
    for (var doc in users.docs) {
      Group group = doc.data();
      group.id = doc.id;
      if (!uniqueIds.contains(group.id)) {
        uniqueIds.add(group.id);
        state.searchList.add(group);
      }
    }
  }

  goToChat(Group toGroup) async {
    Get.toNamed(AppRoutes.GROUPCHAT, parameters: {
      "groupId": toGroup.id ?? "",
      "groupName": toGroup.name ?? "",
      "groupAvatar": toGroup.avatar ?? ""
    });
  }
}
