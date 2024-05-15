import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_chat/common/store/storage.dart';
import 'package:get/get.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;
  //PackageInfo? _platform;
  //String get version => _platform?.version ?? '-';
  bool get isRelease => bool.fromEnvironment("dart.vm.product");
  Locale locale = Locale('en', 'US');
  List<Locale> language = [
    Locale('en', 'US'),
  ];

  @override
  void onInit() {
    super.onInit();
    isFirstOpen = StorageService.to.getBool('STORAGE_DEVICE_FIRST_OPEN_KEY');
  }

  // Future<void> getPlatform() async {
  //   _platform = await PackageInfo.fromPlatform(STORAGE_DEVICE_FIRST_OPEN_KEY, true);
  // }

  Future<void> saveAlreadyOpen() {
    return StorageService.to.setBool('STORAGE_DEVICE_FIRST_OPEN_KEY', true);
  }
}
