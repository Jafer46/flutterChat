import 'package:flutter_chat/pages/group/conroller.dart';
import 'package:get/get.dart';

class GroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupController>(() => GroupController());
  }
}
