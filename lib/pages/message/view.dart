import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/pages/message/widget/message_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  AppBar _biuldAppBar() {
    return AppBar(
      title: Text(
        "Message",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.CONTACT);
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _biuldAppBar(),
      body: const MessageList(),
    );
  }
}
