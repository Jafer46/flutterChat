import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/routes/pages.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/group/chat/widgets/chat_input.dart';
import 'package:flutter_chat/pages/group/chat/widgets/chat_list.dart';

import 'index.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GroupChatPage extends GetView<GroupChatController> {
  const GroupChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primary.shade400,
      elevation: 0,
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //     colors: [
      //       Color.fromARGB(255, 176, 106, 231),
      //       Color.fromARGB(255, 166, 112, 231),
      //       Color.fromARGB(255, 131, 123, 231),
      //       Color.fromARGB(255, 104, 132, 231),
      //     ],
      //     transform: GradientRotation(90),
      //   )),
      // ),
      title: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.GROUPDETAILS, parameters: {
            "groupId": controller.groupId!,
            "groupAvatar": controller.state.groupAvatar.value,
          });
        },
        child: Container(
            padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
                  child: SizedBox(
                    width: 30.w,
                    height: 30.w,
                    child: CachedNetworkImage(
                        imageUrl: controller.state.groupAvatar.value,
                        imageBuilder: (context, imageProvider) => Container(
                              height: 44.w,
                              width: 44.w,
                              margin: null,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(44.w)),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                        errorWidget: (context, url, error) {
                          return const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/D.png'),
                          );
                        }),
                  ),
                ),
                Container(
                    width: 180.w,
                    padding:
                        EdgeInsets.only(top: 10.w, bottom: 0.w, right: 0.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 180.w,
                          height: 44.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.state.groupName.value,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontFamily: 'Avenir',
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  controller.imgFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Camera"),
                onTap: () {},
              )
            ],
          ));
        });
  }

  void _toggleEmojiPicker() {
    controller.changeEmojiSelctorVisible();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 35, 45),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              const Expanded(child: ChatList()),
              chatInput(controller, _showPicker, _toggleEmojiPicker, context),
              ValueListenableBuilder<bool>(
                  valueListenable: controller.isEmojiPickerVisible,
                  builder: (context, value, child) {
                    return value
                        ? SizedBox(
                            height: 180.h,
                            child:
                                EmojiPicker(onEmojiSelected: (category, emoji) {
                              controller.textController.text += emoji.emoji;
                              controller.changeEmojiSelctorVisible();
                            }),
                          )
                        : const SizedBox.shrink();
                  }),
              ValueListenableBuilder<bool>(
                  valueListenable: controller.isNotJoined,
                  builder: (context, value, child) {
                    return value
                        ? SizedBox(
                            height: 80.h,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Join"),
                            ))
                        : const SizedBox.shrink();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
