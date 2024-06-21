import 'package:flutter_chat/pages/group/createGroup/conroller.dart';
import 'package:get/get.dart';

class CreateGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGroupController>(() => CreateGroupController());
  }
}
