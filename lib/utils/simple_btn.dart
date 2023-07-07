import 'package:flutter/material.dart';

import 'helpers.dart';

class Btn extends StatefulWidget {
  final String title;
  final double? borderRadius;
  final double? textPadding;
  final bool? showLoading;
  final double? width;
  final double? loaderWidth;
  final double? loaderHeight;
  final double? height;
  final VoidCallback onTap;
  final Color? backGroundColor;
  final Color? loaderColor;
  final TextStyle? titleStyle;

  const Btn(
      {Key? key,
      required this.title,
      required this.onTap,
      this.backGroundColor,
      this.titleStyle,
      this.loaderWidth,
      this.loaderHeight,
      this.showLoading,
      this.borderRadius,
      this.loaderColor,
      this.width,
      this.height,
      this.textPadding})
      : super(key: key);

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.backGroundColor ?? secondary,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 30)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.textPadding ?? 17.0,
            horizontal: 20,
          ),
          child: Center(
              child: (widget.showLoading ?? false)
                  ? customLoader(
                      color: widget.loaderColor ?? white,
                      height: widget.loaderHeight ?? 25,
                      width: widget.loaderWidth ?? 25)
                  : Text(
                      widget.title,
                      style: widget.titleStyle ??
                           TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: white),
                    )),
        ),
      ),
    );
  }
}
