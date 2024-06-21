import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget flatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = primary,
  String title = "button",
  Color fontColor = primaryAccent,
  double fontsize = 16,
  String fontName = "Montserrat",
  double borderRadius = 16,
}) {
  return Container(
      width: width.w,
      height: height.h,
      child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 16.sp,
          )),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple;
            }
            return fontColor;
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue[200];
            }
            return gbColor;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.w))),
        ),
        onPressed: onPressed,
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor,
              fontSize: fontsize.sp,
              height: 1,
            )),
      ));
}
