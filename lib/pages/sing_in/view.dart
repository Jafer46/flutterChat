import 'package:flutter/material.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/common/widgets/flatButtonWidget.dart';
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
                child: Stack(
                  children: [
                    Positioned(
                        child: Container(
                      height: 76.w,
                      decoration: const BoxDecoration(
                        color: primary,
                        // boxShadow: [

                        // ],
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                    )),
                    Positioned(
                        child: Image.asset(
                      "assets/images/ic_launcher.png",
                      width: 76.w,
                      height: 76.w,
                      fit: BoxFit.cover,
                    ))
                  ],
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
              Text("sign in with social networks ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.sp)),
              Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 50.w),
                  child: flatButtonWidget(
                      onPressed: () {
                        controller.handleSignIn();
                      },
                      width: 800.w,
                      height: 20.w,
                      title: "Google sign in",
                      borderRadius: 2))
            ],
          ));
    }

    Widget buildLoginForm() {
      final _emailController = TextEditingController();
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
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "enter email here",
                    ),
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
                    decoration: const InputDecoration(
                      hintText: "enter password here",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter password";
                      return null;
                    },
                  ),
                ),
                flatButtonWidget(
                    title: "sign in",
                    fontColor: Colors.blueAccent,
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        final email = _emailController.text;
                        controller.handleSignInByPassword(email);
                      }
                    }),
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
        body: Center(
            child: Column(
      children: [buildLogo(), buildLoginForm(), buildThirdPartyLogin()],
    )));
  }
}
