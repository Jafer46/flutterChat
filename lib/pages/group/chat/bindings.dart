import 'index.dart';
import 'package:get/get.dart';

class GroupChatBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupChatController>(() => GroupChatController());
  }
}
