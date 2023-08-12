import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox defaultSizedBox({
  double? height,
  double? width,
  bool bottomBar = false,
}) {
  if (height != null) {
    return SizedBox(
      height: height + (bottomBar ? ScreenUtil().bottomBarHeight : 0),
    );
  } else {
    return SizedBox(
      height: height ?? (bottomBar ? ScreenUtil().bottomBarHeight : 0),
      width: width ?? 0,
    );
  }
}

var borderRadius24 = 24.r;
var borderRadius20 = 20.r;
var borderRadius16 = 16.r;
var borderRadius12 = 12.r;
var borderRadius14 = 14.r;

var bottomBarHeight = ScreenUtil().bottomBarHeight;
var screenWidth = ScreenUtil().screenWidth;
