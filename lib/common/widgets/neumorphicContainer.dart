import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as i;

class NeumorphicContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color shadowColor1;
  final Color shadowColor2;
  final Color backgroundColor;
  final Offset offset1;
  final Offset offset2;
  final double? width;
  final double? height;
  final double blurRadius;
  final bool inset;
  const NeumorphicContainer({
    super.key,
    this.child,
    this.padding,
    this.borderRadius,
    this.shadowColor1 = Colors.transparent,
    this.shadowColor2 = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.offset1 = const Offset(2, 2),
    this.offset2 = const Offset(-2, -2),
    this.width,
    this.height,
    this.blurRadius = 2.0,
    this.inset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [
          i.BoxShadow(
            color: shadowColor1,
            blurRadius: blurRadius,
            offset: offset1,
            inset: inset,
          ),
          i.BoxShadow(
            color: shadowColor2,
            blurRadius: blurRadius,
            offset: offset2,
            inset: inset,
          ),
        ],
      ),
      child: child,
    );
  }
}
