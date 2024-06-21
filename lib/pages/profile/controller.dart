import 'dart:convert';

import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/pages/profile/state.dart';
import 'package:get/get.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  final ProfileState state = ProfileState();
  ProfileController();
  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  asyncLoadAllData() async {
    String profile = await UserStore.to.getProfile();
    if (profile.isNotEmpty) {
      UserLoginResponseEntity userData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      state.head_detail.value = userData;
    }
  }

  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();
    List MyList = [
      {"name": "Account", "icon": "assets/icons/1.png", "route": "/account"},
      {"name": "Group", "icon": "assets/icons/1.png", "route": "/Group"},
      {"name": "Logout", "icon": "assets/icons/1.png", "route": "/account"},
      {"name": "Account", "icon": "assets/icons/1.png", "route": "/account"},
      {"name": "Account", "icon": "assets/icons/1.png", "route": "/account"},
      {"name": "Account", "icon": "assets/icons/1.png", "route": "/account"},
    ];

    for (int i = 0; i < MyList.length; i++) {
      MeListItem result = MeListItem();
      result.icon = MyList[i]["icons"];
      result.name = MyList[i]["name"];
      result.route = MyList[i]["route"];
      state.meListItem.add(result);
    }
  }
}
