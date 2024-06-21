import 'package:flutter_chat/pages/account/controller.dart';
import 'package:get/get.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
