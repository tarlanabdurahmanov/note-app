import 'package:flutter_screenutil/flutter_screenutil.dart';

extension FontSize on num {
  double customFontSize(num fontSize) {
    if (fontSize / fontSize.sp >= 1.1) {
      return fontSize / 1.1;
    } else {
      return fontSize.sp;
    }
  }

  double customHeight(num height) {
    if (height / height.h >= 1.1) {
      return height / 1.1;
    } else {
      return height.h;
    }
  }

  double customWidth(num width) {
    if (width / width.h >= 1.1) {
      return width / 1.1;
    } else {
      return width.h;
    }
  }

  double get csp => customFontSize(this);
  double get ch => customHeight(this);
  double get cw => customWidth(this);
}
