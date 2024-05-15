import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/message.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/services/date.dart';
import 'package:flutter_chat/pages/message/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});

  Widget messageListItem(QueryDocumentSnapshot item) {
    String getText() {
      if (item is QueryDocumentSnapshot<Msg>) {
        return item.data().from_uid == controller.token
            ? item.data().to_name!
            : item.data().from_name!;
      }
      return "";
    }

    String getLastMessage() {
      if (item is QueryDocumentSnapshot<Msg>) {
        return item.data().last_msg ?? "";
      }
      return "";
    }

    Object getLastTime() {
      if (item is QueryDocumentSnapshot<Msg>) {
        return item.data().last_time ?? "";
      }
      return "";
    }

    String getAvatar() {
      if (item is QueryDocumentSnapshot<Msg>) {
        return item.data().from_uid == controller.token
            ? item.data().to_avatar!
            : item.data().from_avatar!;
      }
      return "";
    }

    return Container(
        padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
        child: InkWell(
            onTap: () {
              if (item is QueryDocumentSnapshot<Msg>) {
                var to_uid = "";
                var to_name = "";
                var to_avatar = "";
                if (item.data().from_uid == controller.token) {
                  to_uid = item.data().to_uid ?? "";
                  to_name = item.data().to_name ?? "";
                  to_avatar = item.data().to_avatar ?? "";
                } else {
                  to_uid = item.data().from_uid ?? "";
                  to_name = item.data().from_name ?? "";
                  to_avatar = item.data().from_avatar ?? "";
                }
                Get.toNamed(AppRoutes.CHAT, parameters: {
                  "doc_id": item.id,
                  "to_uid": to_uid,
                  "to_name": to_name,
                  "to_avatar": to_avatar,
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
                  child: SizedBox(
                    width: 54.w,
                    height: 54.w,
                    child: CachedNetworkImage(
                      imageUrl: getAvatar(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 54.w,
                        height: 54.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(54.w)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        backgroundImage: AssetImage('assests/images/D.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 180.w,
                        height: 48.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getText(),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              getLastMessage(),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60.w,
                        height: 54.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              duTimeLineFormat(
                                  (getLastTime() as Timestamp).toDate()),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: "Avenir", fontSize: 12.sp),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var item = controller.state.msgList[index];
                    return messageListItem(item);
                  }, childCount: controller.state.msgList.length),
                ),
              )
            ],
          ),
        ));
  }
}
