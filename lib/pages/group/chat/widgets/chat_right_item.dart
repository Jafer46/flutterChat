import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/common/entities/msgcontent.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget chatRightItem(
    BuildContext context, Msgcontent item, Function showMessageOptions) {
  return GestureDetector(
    onLongPress: () {
      showMessageOptions(context, item);
    },
    child: Container(
        padding:
            EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 230.w,
                minHeight: 40.w,
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10.w, top: 0.w),
                padding: EdgeInsets.only(
                    top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 176, 106, 231),
                        Color.fromARGB(255, 166, 112, 231),
                        Color.fromARGB(255, 131, 123, 231),
                        Color.fromARGB(255, 104, 132, 231),
                      ],
                      transform: GradientRotation(90),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: item.type == "text"
                    ? Text("${item.content}")
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 230.w,
                          minHeight: 40.w,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.PHOTOIMAGEVIEW,
                                parameters: {"url": item.content ?? ""});
                          },
                          child: CachedNetworkImage(
                            imageUrl: "${item.content}",
                          ),
                        ),
                      ),
              ),
            )
          ],
        )),
  );
}
