import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/group/createGroup/conroller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateGroupPage extends GetView<CreateGroupController> {
  const CreateGroupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.w),
            child: Form(
              key: controller.formState,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.w),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.groupNameController,
                      decoration: const InputDecoration(
                        label: Text("Group Name"),
                      ),
                      validator: (value) {},
                    ),
                    //ImagePickerField(),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.formState.currentState!.validate()) {
                          controller.createGroup();
                        }
                      },
                      child: const Text("Create"),
                    )
                  ],
                ),
              ),
            )));
  }
}
