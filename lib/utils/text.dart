import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/custom_font_size.dart';

Text defaultText(
  String text, {
  double? fontSize,
  double? height,
  FontWeight? fontWeight,
  Color? color,
  int? maxLines,
  TextOverflow? overflow,
  TextAlign? textAlign,
  TextStyle? style,
}) {
  return Text(
    text,
    style: style ??
        TextStyle(
          fontSize: fontSize ?? 15.csp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? AppColors.whiteColor,
          height: height,
          // fontFamily: "UberMoveText",
        ),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
  );
}
