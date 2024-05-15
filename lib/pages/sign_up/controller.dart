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

class SignUpController extends GetxController {
  final state = SignUpState();
  SignUpController();
  final db = FirebaseFirestore.instance;
  Future<void> handleSignUpByGoogle() async {
    try {
      var user = await _googleSigIn.signIn();
      if (user != null) {
        final _gAuthentication = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _gAuthentication.idToken,
          accessToken: _gAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(_credential);
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
            .collection("users")
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
              .collection("users")
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
      print(e);
    }
  }

  Future<void> handleSignUpByPassword(name, email, password) async {
    try {
      var userBase = await db
          .collection("users")
          .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore(),
          )
          .where("email", isEqualTo: email)
          .get();
      if (userBase.docs.isEmpty) {
        final data = UserData(
            name: name,
            email: email,
            photourl: "",
            fcmtoken: "",
            isOnline: false,
            addTime: Timestamp.now());
        await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .add(data);
      }
      toastInfo(msg: "login success");
      Get.offAndToNamed(AppRoutes.APLLICATION);
    } catch (err) {
      toastInfo(msg: "login error");
      print(err);
    }
  }

  goToSignIn() {
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
