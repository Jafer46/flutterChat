import 'package:flutter_chat/pages/message/photoviewer/controller.dart';
import 'package:get/get.dart';

class PhotoViewerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoViewerController>(() => PhotoViewerController());
  }
}
