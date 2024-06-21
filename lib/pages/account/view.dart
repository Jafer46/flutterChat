import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/account/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Column(children: [
        ValueListenableBuilder<bool>(
            valueListenable: controller.isFilePicked,
            builder: (context, value, child) {
              return value
                  ? SizedBox(
                      height: 180.h,
                      child: Image.file(
                        File(controller.pickedFile!.path!),
                        fit: BoxFit.cover,
                      ))
                  : const SizedBox.shrink();
            }),
        ElevatedButton(
            onPressed: () {
              controller.selectFile();
            },
            child: const Text("pickFile")),
        Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(label: Text("Name")),
              ),
              TextFormField(
                controller: controller.passController,
                decoration: const InputDecoration(label: Text("Password")),
              ),
              ElevatedButton(
                  onPressed: () => controller.updateAccount(),
                  child: const Text("Update"))
            ],
          ),
        )
      ]),
    );
  }
}
