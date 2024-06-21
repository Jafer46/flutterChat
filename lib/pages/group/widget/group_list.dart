import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/group.dart';
//import 'package:flutter_chat/common/entities/message.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/services/date.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/group/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupList extends GetView<GroupController> {
  const GroupList({super.key});

  Widget messageListItem(Group item) {
    if (item.avatar == null || item.avatar!.isEmpty) {
      String a = item.name![0].toUpperCase();
      item.avatar = 'assets/images/$a.png';
    }

    return Container(
        padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
        margin: EdgeInsets.only(bottom: 2.h),
        child: InkWell(
            onTap: () {
              var toName = item.name ?? "";
              var toAvatar = item.avatar ?? "";

              Get.toNamed(AppRoutes.GROUPCHAT, parameters: {
                "groupId": item.id ?? "",
                "groupName": toName,
                "groupAvatar": toAvatar,
              });
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
                        imageUrl: item.avatar!,
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
                        errorWidget: (context, url, error) {
                          String a = item.name![0].toUpperCase();
                          return CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/$a.png'));
                        }),
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
                        height: 54.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? "",
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              item.last_msg ?? "",
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
                                  (item.last_time ?? "" as Timestamp).toDate()),
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
          controller: controller.groupRefreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 66, 69, 78),
                AppColor.primary,
              ],
            )),
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
          ),
        ));
  }
}
