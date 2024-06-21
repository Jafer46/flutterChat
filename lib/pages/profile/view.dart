import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/profile/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Profile",
        style: TextStyle(
          fontSize: 18.sp,
        ),
      ),
    );
  }

  Widget meItem(MeListItem item) {
    return Container(
      height: 56.w,
      margin: EdgeInsets.only(bottom: 1.w),
      padding: EdgeInsets.only(top: 0.w, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: () {
          Get.toNamed(item.route!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 56.w,
                  child: Image(
                    image: AssetImage(item.icon ?? "assets/icons/1.png"),
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14.w),
                  child: Text(item.name ?? ""),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var item = controller.state.meListItem[index];
                      return meItem(item);
                    }, childCount: controller.state.meListItem.length),
                  )),
            ],
          )),
    );
  }
}
