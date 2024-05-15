import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/message/widget/message_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
