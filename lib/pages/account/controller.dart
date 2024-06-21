import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/services/getRandomString.dart';
import 'package:flutter_chat/pages/account/index.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AccountController extends GetxController {
  AccountController();

  AcccountState state = AcccountState();

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  ValueNotifier<bool> isFilePicked = ValueNotifier<bool>(false);

  PlatformFile? pickedFile;

  selectFile() async {
    print("hello");
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result == null) return;

      pickedFile = result.files.first;
      isFilePicked.value = true;
    } catch (e) {
      print('picke file has error $e');
    }
  }

  uploadFile() async {
    try {
      final fileName = getRandomString(15) + extension(pickedFile!.path!);
      final path = 'chat/$fileName';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      UploadTask uploadTask = ref.putFile(file);
      final snapShot = await uploadTask.whenComplete(() => {});
      return snapShot.ref.getDownloadURL();
    } catch (e) {
      print('paicke file has error $e');
    }
  }

  updateAccount() async {
    if (pickedFile != null) {
      final url = uploadFile();
      print(url);
    }
  }
}
