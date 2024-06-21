import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/group.dart';
import 'package:flutter_chat/common/entities/userData.dart';
import 'package:flutter_chat/pages/contact/controller.dart';
import 'package:flutter_chat/pages/group/searchGroup/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchGroupList extends GetView<SearchGroupController> {
  const SearchGroupList({super.key});

  Widget buildListItem(Group item) {
    if (item.avatar == null || item.avatar!.isEmpty) {
      String a = item.name.toString()[0].toUpperCase();
      item.avatar = 'assets/images/$a.png';
    }
    return InkWell(
        onTap: () {
          if (item.id != null) {
            controller.goToChat(item);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12.w,
            ),
            SizedBox(
                width: 34.w,
                height: 34.w,
                child: CachedNetworkImage(
                  imageUrl: "${item.avatar}",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 54.w,
                    height: 54.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(54.w)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/D.png'),
                  ),
                )),
            SizedBox(
              width: 12.w,
            ),
            Container(
              width: 250.w,
              padding: EdgeInsets.only(top: 15.w, left: 0.w, right: 0.w),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffe5efe5)))),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.w,
                    child: Text(
                      item.name ?? "",
                      style: TextStyle(
                        fontFamily: "Avenir",
                        color: Colors.amber,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = controller.state.searchList[index];
                  return buildListItem(item);
                },
                childCount: controller.state.searchList.length,
              ),
            ),
          )
        ]));
  }
}
