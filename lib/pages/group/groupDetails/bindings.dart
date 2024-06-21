import 'package:flutter_chat/pages/group/groupDetails/index.dart';
import 'package:get/get.dart';

class GroupDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupDetailsController>(() => GroupDetailsController());
  }
}
