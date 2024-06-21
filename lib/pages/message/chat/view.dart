import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/message/chat/widgets/chat_input.dart';
import 'package:flutter_chat/pages/message/chat/widgets/chat_list.dart';
import 'index.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

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
      title: Container(
          padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
                child: InkWell(
                  child: SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: CachedNetworkImage(
                          imageUrl: controller.state.to_avatar.value,
                          imageBuilder: (context, imageProvider) => Container(
                                height: 44.w,
                                width: 44.w,
                                margin: null,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(44.w)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                          errorWidget: (context, url, error) {
                            String a = controller.state.to_name
                                .toString()[0]
                                .toUpperCase();
                            return CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/$a.png'),
                            );
                          })),
                ),
              ),
              Container(
                  width: 180.w,
                  padding: EdgeInsets.only(top: 10.w, bottom: 0.w, right: 0.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180.w,
                        height: 44.w,
                        child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.state.to_name.value,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'Avenir',
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ))
                              ],
                            )),
                      )
                    ],
                  ))
            ],
          )),
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
                  Navigator.pop(context);
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
                            child: EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                controller.textController.text += emoji.emoji;
                                controller.changeEmojiSelctorVisible();
                              },
                            ),
                          )
                        : const SizedBox.shrink();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
