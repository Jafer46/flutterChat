import 'package:flutter_chat/pages/application/controller.dart';
import 'package:flutter_chat/pages/contact/controller.dart';
import 'package:flutter_chat/pages/group/controller.dart';
import 'package:flutter_chat/pages/message/controller.dart';
import 'package:flutter_chat/pages/profile/index.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<GroupController>(() => GroupController());
  }
}
