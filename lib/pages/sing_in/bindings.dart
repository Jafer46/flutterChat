import 'package:flutter_chat/pages/contact/controller.dart';

import 'index.dart';
import 'package:get/get.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
