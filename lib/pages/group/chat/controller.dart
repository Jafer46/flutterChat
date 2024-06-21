// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/common/entities/msgcontent.dart';
import 'package:flutter_chat/common/entities/names.dart';
import 'package:flutter_chat/common/entities/userGroups.dart';
import 'package:flutter_chat/common/services/getRandomString.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'index.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChatController extends GetxController {
  GroupChatController();
  GroupChatState state = GroupChatState();
  var groupId = Get.parameters['groupId'];
  var textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final userid = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  ValueNotifier<bool> isEmojiPickerVisible = ValueNotifier<bool>(false);
  ValueNotifier<bool> isEditing = ValueNotifier<bool>(false);
  ValueNotifier<bool> isNotJoined = ValueNotifier<bool>(false);
  Msgcontent? message;
  String currentMessageId = "";
  // ignore: prefer_typing_uninitialized_variables
  var listener;

  File? _photo;
  final ImagePicker _imagePicker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print("No iamge selected");
    }
  }

  Future getImageUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  sendImageMessage(String url) async {
    final content = Msgcontent(
        uid: userid, content: url, type: "image", addtime: Timestamp.now());

    await db
        .collection(Entity.group)
        .doc(groupId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgContent, options) =>
                msgContent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db
        .collection(Entity.group)
        .doc(groupId)
        .update({"last_msg": "image", "last_time": Timestamp.now()});
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = getRandomString(15) + extension(_photo!.path);
    try {
      final ref = FirebaseStorage.instance.ref("chat").child(fileName);
      ref.putFile(_photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImageUrl(fileName);
            sendImageMessage(imgUrl);
          case TaskState.canceled:
          case TaskState.error:
            break;
        }
      });
    } catch (e) {
      print("there is an error $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    state.groupName.value = data['groupName'] ?? "";
    state.groupAdmin.value = data['groupAdmin'] ?? "";
    state.groupAvatar.value = data['groupAvatar'] ?? "";
    checkIsJoined();
  }

  checkIsJoined() async {
    try {
      var userGroup = await db
          .collection(Entity.users)
          .doc(userid)
          .collection(Entity.groupList)
          .withConverter(
              fromFirestore: UserGroups.fromFirestore,
              toFirestore: (UserGroups userGroups, options) =>
                  userGroups.toFirestore())
          .where("id", isEqualTo: groupId)
          .get();

      if (userGroup.docs.isEmpty) {
        isNotJoined.value = true;
      }
      isNotJoined.value = false;
    } catch (e) {
      print(e);
    }
  }

  JoinGroup() async {
    try {
      UserGroups userGroups = UserGroups(groupId: groupId);
      await db
          .collection(Entity.users)
          .doc(userid)
          .collection(Entity.groupList)
          .withConverter(
              fromFirestore: UserGroups.fromFirestore,
              toFirestore: (UserGroups userGroups, options) =>
                  userGroups.toFirestore())
          .add(userGroups);
      isNotJoined.value = false;
    } catch (e) {
      print(e);
    }
  }

  sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: userid,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );
    await db
        .collection(Entity.group)
        .doc(groupId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgContent, options) =>
                msgContent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db
        .collection(Entity.group)
        .doc(groupId)
        .update({"last_msg": sendContent, "last_time": Timestamp.now()});
  }

  @override
  void onReady() {
    super.onReady();

    var messages = db
        .collection(Entity.group)
        .doc(groupId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgcontent, options) =>
                msgcontent.toFirestore())
        .orderBy("addtime", descending: false);
    state.msgcontentList.clear();

    listener = messages.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                message = change.doc.data();
                message!.id = change.doc.id;
                state.msgcontentList.insert(0, message!);
              }
              break;
            case DocumentChangeType.modified:
              state.msgcontentList
                  .assignAll(state.msgcontentList.map((element) {
                if (element!.id == change.doc.id) {
                  Msgcontent? msg = change.doc.data();
                  msg!.id = change.doc.id;
                  return msg;
                }
              }));

              break;
            case DocumentChangeType.removed:
              state.msgcontentList.removeWhere((m) => m!.id == change.doc.id);
              break;
          }
        }
      },
      onError: (error) => print("listen failded: $error"),
    );
  }

  void changeEmojiSelctorVisible() {
    isEmojiPickerVisible.value = !isEmojiPickerVisible.value;
  }

  void changeIsEditing() {
    isEditing.value = !isEditing.value;
  }

  void deleteMessage(Msgcontent message) async {
    try {
      await db
          .collection(Entity.group)
          .doc(groupId)
          .collection("msglist")
          .doc(message.id)
          .delete();
    } catch (e) {
      print("delete message has error $e");
    }
  }

  void updateMessage() async {
    try {
      if (currentMessageId.isEmpty) return;
      await db
          .collection(Entity.group)
          .doc(groupId)
          .collection("msglist")
          .doc(currentMessageId)
          .update({"content": textController.text});
    } catch (e) {
      print("edit message has error $e");
    }
  }

  void editMessage(Msgcontent message) {
    textController.text = message.content!;
    currentMessageId = message.id!;
    print(message.id);
    changeIsEditing();
    print(isEditing.value);
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
