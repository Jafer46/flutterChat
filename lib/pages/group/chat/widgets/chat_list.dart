import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/msgcontent.dart';
import 'package:flutter_chat/pages/group/chat/controller.dart';
import 'package:flutter_chat/pages/group/chat/widgets/chat_left_item.dart';
import 'package:flutter_chat/pages/group/chat/widgets/chat_right_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatList extends GetView<GroupChatController> {
  const ChatList({super.key});

  void _showMessageOptions(BuildContext context, Msgcontent message) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.delete_sharp,
                  color: Colors.red,
                ),
                title: const Text("Delete"),
                onTap: () {
                  controller.deleteMessage(message);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit"),
                onTap: () {
                  controller.editMessage(message);
                  Navigator.pop(context);
                },
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 50.h),
        child: CustomScrollView(
          reverse: true,
          controller: controller.msgScrolling,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.msgcontentList[index];
                    if (controller.userid == item!.uid) {
                      return chatRightItem(context, item, _showMessageOptions);
                    }

                    return chatLeftItem(item);
                  },
                  childCount: controller.state.msgcontentList.length,
                ),
              ),
            ),
          ],
        )));
  }
}
