import 'package:flutter_chat/pages/group/searchGroup/controller.dart';
import 'package:get/get.dart';

class SearchGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchGroupController>(() => SearchGroupController());
  }
}
