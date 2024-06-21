import 'package:flutter/material.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/common/widgets/flatButtonWidget.dart';
import 'package:path/path.dart';
import 'index.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildLogo() {
      return Container(
          width: 110.w,
          margin: EdgeInsets.only(top: 84.h),
          child: Column(
            children: [
              Container(
                width: 76.w,
                height: 76.w,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Image.asset(
                  "assets/images/ic_launcher.png",
                  width: 76.w,
                  height: 76.w,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                child: Text(
                  "Let's chat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 1,
                  ),
                ),
              )
            ],
          ));
    }

    Widget buildThirdPartyLogin() {
      return SizedBox(
          width: 400.w,
          //margin: EdgeInsets.only(bottom: 280.h),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 50.w),
                  child: flatButtonWidget(
                      onPressed: () {
                        controller.handleSignIn();
                      },
                      width: 800.w,
                      height: 30.w,
                      title: "Google sign in",
                      borderRadius: 4))
            ],
          ));
    }

    Widget buildLoginForm() {
      final emailController = TextEditingController();
      final passController = TextEditingController();
      GlobalKey<FormState> formState = GlobalKey();
      return Form(
          key: formState,
          child: Container(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 16.sp),
                  child: TextFormField(
                    key: const ValueKey("email"),
                    controller: emailController,
                    decoration: const InputDecoration(
                        label: Text(
                      "Email",
                      style: TextStyle(color: Colors.blueAccent),
                    )),
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter email";
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 16.sp),
                  child: TextFormField(
                    key: const ValueKey("password"),
                    controller: passController,
                    decoration: const InputDecoration(
                        label: Text(
                      "Password",
                      style: TextStyle(color: Colors.blueAccent),
                    )),
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter password";
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formState.currentState!.validate()) {
                      final email = emailController.text;
                      final password = passController.text;
                      controller.handleSignInByPassword(email, password);
                    }
                  },
                  child: Text("Sign in"),
                ),
                Container(
                    //decoration: BoxDecoration(backgroundBlendMode: BlendMode.clear),
                    padding: EdgeInsets.only(top: 5.sp),
                    child: TextButton(
                      onPressed: () => controller.gotToSignUp(),
                      child: const Text(
                        "New to app?sign up ->",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    )),
              ],
            ),
          ));
    }

    return Scaffold(
        body: SafeArea(
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [buildLogo(), buildLoginForm(), buildThirdPartyLogin()],
            )),
      ),
    ));
  }
}
