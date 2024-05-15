import 'package:flutter/material.dart';
//import 'package:flutter_chat/common/middlewares/router_welcome.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/pages/application/index.dart';
import 'package:flutter_chat/pages/message/bindings.dart';
import 'package:flutter_chat/pages/message/chat/index.dart';
import 'package:flutter_chat/pages/message/photoviewer/index.dart';
import 'package:flutter_chat/pages/message/view.dart';
import 'package:flutter_chat/pages/welcome/index.dart';
import 'package:flutter_chat/pages/sing_in/index.dart';
import 'package:flutter_chat/pages/contact/index.dart';
import 'package:get/get.dart';

import '../../pages/group/chat/index.dart';
import '../../pages/group/index.dart';
import '../../pages/profile/index.dart';
import '../../pages/sign_up/index.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = AppRoutes.INITIAL;
  // ignore: constant_identifier_names
  static const APLLICATION = AppRoutes.APLLICATION;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      //middlewares: [RouteWelcomeMiddleware(priority: 1)]
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.APLLICATION,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
    ),
    GetPage(
        name: AppRoutes.CHAT,
        page: () => const ChatPage(),
        binding: ChatBinding()),
    GetPage(
        name: AppRoutes.CONTACT,
        page: () => const ContactPage(),
        binding: ContactBinding()),
    GetPage(
        name: AppRoutes.MESSAGE,
        page: () => const MessagePage(),
        binding: MessageBinding()),
    GetPage(
        name: AppRoutes.PHOTOIMAGEVIEW,
        page: () => const PhotoViewerPage(),
        binding: PhotoViewerBinding()),
    GetPage(
        name: AppRoutes.ME,
        page: () => const ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: AppRoutes.GROUP,
        page: () => const GroupPage(),
        binding: GroupBindings()),
    GetPage(
        name: AppRoutes.GROUPCHAT,
        page: () => const GroupChatPage(),
        binding: GroupChatBindings()),
  ];
}
