import 'package:flutter/material.dart';
//import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/application/controller.dart';
import 'package:flutter_chat/pages/contact/view.dart';
import 'package:flutter_chat/pages/message/view.dart';
import 'package:flutter_chat/pages/profile/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildPageView() {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: const [
          MessagePage(),
          ContactPage(),
          ProfilePage(),
        ],
      );
    }

    Widget buildBottomNavigationBar() {
      return Obx(() => BottomNavigationBar(
            backgroundColor: const Color(0xFF2E3239),
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

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 49, 53, 62),
            Color.fromARGB(255, 24, 27, 33)
          ],
        )),
        child: Scaffold(
          backgroundColor: const Color(0xFF2E3239),
          body: buildPageView(),
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0xFF35393F),
                  blurRadius: 30,
                  offset: Offset(-5, -30),
                ),
                BoxShadow(
                  color: Color(0xFF23262A),
                  blurRadius: 50,
                  offset: Offset(5, 30),
                )
              ]),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: buildBottomNavigationBar())),
        ));
  }
}
