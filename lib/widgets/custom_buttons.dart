import 'package:flutter/material.dart';

class CustomButtons {
  primaryButton(
      {VoidCallback? onTap,
      required Size size,
      Key? key,
      double? fontSize,
      FontWeight? fontWeight,
      double? borderRadius,
      double? width,
      double? height,
      required String text}) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap() : () {},
      child: Container(
        key: key,
        alignment: Alignment.center,
        height: height ?? size.width * 0.115,
        width: width ?? size.width * 0.45,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(borderRadius ?? 50)),
        child: RichText(
          text: TextSpan(
            text: text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ),
          softWrap: false,
        ),
      ),
    );
  }
}
