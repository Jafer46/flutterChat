import 'package:flutter_chat/pages/photoviewer/index.dart';
import 'package:get/get.dart';

class PhotoViewerController extends GetxController {
  final PhotoViewerState state = PhotoViewerState();
  PhotoViewerController();

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    if (data['url'] != null) {
      state.url.value = data['url']!;
    }
  }
}
