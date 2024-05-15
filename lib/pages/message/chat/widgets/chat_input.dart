import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/pages/group/chat/index.dart';
import 'package:flutter_chat/pages/message/chat/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as inset;
import 'dart:math' as math;

Widget chatInput(ChatController controller, Function showPicker,
    Function toggleEmojiPicker, BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.w),
          child: Container(
              width: 320.w,
              height: 60.h,
              padding: const EdgeInsets.all(0),
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: const inset.BoxDecoration(
                  color: Color.fromARGB(255, 36, 39, 48),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    inset.BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                        inset: true),
                    inset.BoxShadow(
                        color: Color.fromARGB(179, 176, 176, 176),
                        blurRadius: 2,
                        offset: Offset(-1, -1),
                        inset: true)
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.changeEmojiSelctorVisible();
                        },
                        child: const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.red,
                        )),
                    Expanded(
                      child: Container(
                          height: 55.h,
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            controller: controller.textController,
                            autofocus: false,
                            focusNode: controller.contentNode,
                            decoration: const InputDecoration(
                                hintText: "Send messages...",
                                hintStyle: TextStyle(color: Colors.white38),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          )),
                    ),
                    Container(
                        height: 30.h,
                        width: 30.w,
                        margin: EdgeInsets.only(left: 5.w),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.photo_outlined,
                            //size: 35.w,
                            color: Colors.red,
                          ),
                          onTap: () {
                            showPicker(context);
                          },
                        )),
                    ValueListenableBuilder<bool>(
                        valueListenable: controller.isEditing,
                        builder: (context, value, child) {
                          return value
                              ? Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.h))),
                                  child: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      controller.changeIsEditing();
                                      controller.textController.text = "";
                                    },
                                  ),
                                )
                              : const SizedBox.shrink();
                        }),
                    Transform.rotate(
                      angle: -30 * math.pi / 180,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (controller.textController.text.isEmpty) {
                            return;
                          }
                          if (controller.isEditing.value) {
                            controller.updateMessage();
                            controller.changeIsEditing();
                            return;
                          }
                          controller.sendMessage();
                          controller.textController.text = "";
                        },
                      ),
                    ),
                  ]))));
}
