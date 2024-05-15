import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/userData.dart';
import 'package:flutter_chat/pages/contact/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  Widget buildListItem(UserData item) {
    if (item.photourl == null) {
      String a = item.name.toString()[0].toUpperCase();
      item.photourl = 'assets/images/$a.png';
    }
    return InkWell(
        onTap: () {
          print(item.id);
          if (item.id != null) {
            print("hello from tap");
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
                  imageUrl: "${item.photourl}",
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
                  var item = controller.state.contactList[index];
                  return buildListItem(item);
                },
                childCount: controller.state.contactList.length,
              ),
            ),
          )
        ]));
  }
}
