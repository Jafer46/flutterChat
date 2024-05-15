import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/store/config.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:get/get.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    print(ConfigStore.to.isFirstOpen);

    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    }

    if (UserStore.to.isLogin == false) {
      return const RouteSettings(name: AppRoutes.APLLICATION);
    }

    return const RouteSettings(name: AppRoutes.SIGN_IN);
  }
}
