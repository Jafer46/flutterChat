import 'package:flutter/foundation.dart';
import 'package:flutter_chat/common/entities/names.dart';
import 'package:flutter_chat/common/entities/userData.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/widgets/toast.dart';
import 'package:flutter_chat/models/user.dart';
import 'index.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn _googleSigIn = GoogleSignIn(scopes: <String>['openid ']);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;
  Future<void> handleSignIn() async {
    try {
      var user = await _googleSigIn.signIn();
      if (user != null) {
        final gAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: gAuthentication.idToken,
          accessToken: gAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);
        var userBase = await db
            .collection(Entity.users)
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();

        if (userBase.docs.isEmpty) {
          final data = UserData(
              id: id,
              name: displayName,
              email: email,
              photourl: photoUrl,
              fcmtoken: "",
              addTime: Timestamp.now());
          await db
              .collection(Entity.users)
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) =>
                    userData.toFirestore(),
              )
              .add(data);
        }
        toastInfo(msg: "login success");
        Get.offAndToNamed(AppRoutes.APLLICATION);
      }
    } catch (e) {
      toastInfo(msg: "login error");
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> handleSignInByPassword(email, password) async {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: email, password: password);
    final userBase = await db
        .collection(Entity.users)
        .where("email", isEqualTo: email)
        .get();
    if (userBase.docs.isEmpty) {
      if (kDebugMode) {
        print("user not found");
      }
      return;
    }

    UserData userData = userBase.docs
        .map((e) => UserData.fromFirestore(userBase.docs.first, null))
        .single;

    UserLoginResponseEntity userProfile = UserLoginResponseEntity();
    userProfile.email = email;
    userProfile.accessToken = userBase.docs.first.id;
    userProfile.displayName = userData.name;
    userProfile.photoUrl = userData.photourl ?? "";
    if (kDebugMode) {
      print("User access token ${userProfile.accessToken}");
    }
    UserStore.to.saveProfile(userProfile);

    Get.offAndToNamed(AppRoutes.APLLICATION);
  }

  gotToSignUp() {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
  }
}
