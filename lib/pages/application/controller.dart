import 'package:flutter/material.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/application/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController with WidgetsBindingObserver {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  final db = FirebaseFirestore.instance;
  final userid = UserStore.to.token;
  void handlePageChanged(int index) {
    state.page = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  void updateUserOnlineStatus(bool isOnline) async {
    await db.collection('users').doc(userid).update({isOnline: isOnline});
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['chat', 'contact', 'profile'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
          color: Colors.lightBlue,
        ),
        activeIcon: Icon(
          Icons.message,
          color: Colors.blueAccent,
        ),
        label: 'chat',
        backgroundColor: primary,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.contact_page,
          color: Colors.lightBlue,
        ),
        activeIcon: Icon(
          Icons.contact_page,
          color: Colors.blueAccent,
        ),
        label: 'contact',
        backgroundColor: primary,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.lightBlue,
        ),
        activeIcon: Icon(
          Icons.person,
          color: Colors.blueAccent,
        ),
        label: 'profile',
        backgroundColor: primary,
      ),
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        updateUserOnlineStatus(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        updateUserOnlineStatus(false);
        break;
    }
  }
}
