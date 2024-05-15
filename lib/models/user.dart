import 'dart:convert';

import 'package:flutter_chat/common/store/storage.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;

  String token = '';

  final _profile = UserLoginResponseEntity().obs;

  bool get isLogin => _isLogin.value;
  UserLoginResponseEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString("STORAGE_USER_TOKEN_KEY");
    var profileOffline =
        StorageService.to.getString("STORAGE_USER_PROFILE_KEY");
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString("STORAGE_USER_TOKEN_KEY", value);
    token = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";

    return StorageService.to.getString("STORAGE_USER_PROFILE_KEY");
  }

  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    _isLogin.value = true;
    StorageService.to
        .setString("STORAGE_USER_PROFILE_KEY", json.encode(profile.tojson()));
    setToken(profile.accessToken!);
  }

  Future<void> onLogOut() async {
    await StorageService.to.remove("STORAGE_USER_TOKEN_KEY");
    await StorageService.to.remove("STORAGE_USER_PROFILE_KEY");
    _isLogin.value = false;
    token = '';
  }
}

class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  UserLoginResponseEntity({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        displayName: json['displau_name'],
        email: json['email'],
        photoUrl: json["photoUrl"],
      );
  Map<String, dynamic> tojson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}

class MeListItem {
  String? name;
  String? icon;
  String? explain;
  String? route;

  MeListItem({
    this.name,
    this.explain,
    this.icon,
    this.route,
  });

  factory MeListItem.FromJson(Map<String, dynamic> json) => MeListItem(
        name: json["name"],
        icon: json['icon'],
        explain: json['explain'],
        route: json["route"],
      );
}
