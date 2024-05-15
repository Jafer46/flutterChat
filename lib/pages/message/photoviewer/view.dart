import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './index.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerPage extends GetView<PhotoViewerController> {
  const PhotoViewerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(imageProvider: NetworkImage(controller.state.url.value)),
    );
  }
}
