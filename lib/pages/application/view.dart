import 'package:flutter/material.dart';
import 'package:flutter_chat/common/value/appColor.dart';
//import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/application/controller.dart';
import 'package:flutter_chat/pages/contact/view.dart';
import 'package:flutter_chat/pages/group/index.dart';
import 'package:flutter_chat/pages/group/view.dart';
import 'package:flutter_chat/pages/message/view.dart';
import 'package:flutter_chat/pages/profile/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
      children: const [
        MessagePage(),
        GroupPage(),
        ProfilePage(),
      ],
    );
  }

  Widget buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          backgroundColor: AppColor.primary,
          items: controller.bottomTabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTap,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.amber,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 66, 69, 78),
            AppColor.primary,
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: buildPageView(),
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF35393F),
                      blurRadius: 5,
                      offset: Offset(-5, -5),
                    ),
                    BoxShadow(
                      color: Color(0xFF23262A),
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    )
                  ]),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: buildBottomNavigationBar())),
        ));
  }
}
