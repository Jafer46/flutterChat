// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/msgcontent.dart';
import 'package:flutter_chat/common/entities/names.dart';
import 'package:flutter_chat/common/services/getRandomString.dart';
import 'package:flutter_chat/models/user.dart';
import 'index.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  ChatController();
  ChatState state = ChatState();
  var doc_id = Get.parameters['doc_id'];
  var textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final userid = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  ValueNotifier<bool> isEmojiPickerVisible = ValueNotifier<bool>(false);
  ValueNotifier<bool> isEditing = ValueNotifier<bool>(false);
  Msgcontent? message;
  String currentMessageId = "";
  var listener;
  int editMessageIndex = 0;

  File? _photo;
  final ImagePicker _imagePicker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    _photo = File(pickedFile.path);
    print("file is picked");
    uploadFile();
  }

  // Future imgFromGallery() async {
  //   if (!Platform.isAndroid) {
  //     // Web platform
  //     final fileInput =
  //         html.document.getElementById('file-input') as html.InputElement;
  //     if (fileInput.files?.isNotEmpty ?? false) {
  //       _photo = html.File(
  //           html.Url.createObjectUrl(fileInput.files?.first) as List<Object>,
  //           fileInput.files!.first.name) as File?;
  //     }
  //   } else {
  //     // Mobile platform
  //     final pickedFile =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //     }
  //   }
  // }

  Future getImageUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  void sendImageMessage(String url) async {
    final content = Msgcontent(
        uid: userid, content: url, type: "image", addtime: Timestamp.now());

    await db
        .collection(Entity.message)
        .doc(doc_id)
        .collection(Entity.messageList)
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
        .collection("message")
        .doc(doc_id)
        .update({"last_msg": "image", "last_time": Timestamp.now()});
  }

  Future<void> uploadFile() async {
    if (_photo == null) return;

    final fileName = '${getRandomString(15)} ${extension(_photo!.path)}';

    final storageRef = FirebaseStorage.instance.ref('chat/$fileName');

    try {
      final uploadTask = storageRef.putFile(_photo!);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      sendImageMessage(imageUrl);
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    state.to_uid.value = data['to_uid'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
  }

  void sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: userid,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );
    await db
        .collection("message")
        .doc(doc_id)
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
        .collection("message")
        .doc(doc_id)
        .update({"last_msg": sendContent, "last_time": Timestamp.now()});
  }

  @override
  void onReady() {
    super.onReady();

    var messages = db
        .collection("message")
        .doc(doc_id)
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
                print(message!.type);
                state.msgcontentList.insert(0, message!);
              }
              break;
            case DocumentChangeType.modified:
              int index =
                  state.msgcontentList.indexOf((m) => m.id == change.doc.id);
              message = change.doc.data();
              message!.id = change.doc.id;
              state.msgcontentList[index] = message!;
              break;
            case DocumentChangeType.removed:
              state.msgcontentList.removeWhere((m) => m.id == change.doc.id);
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
          .collection("message")
          .doc(doc_id)
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
          .collection("message")
          .doc(doc_id)
          .collection("msglist")
          .doc(currentMessageId)
          .update({"content": textController.text});
    } catch (e) {
      print("edit message has error $e");
    }
  }

  void editMessage(Msgcontent message, int index) {
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
