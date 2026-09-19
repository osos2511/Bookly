import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

/// Getters rather than constants so every style is re-resolved against the
/// current ScreenUtil scale after a rotation or split-screen resize.
class StylesManager {
  static TextStyle get textStyle14 => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get textStyle16 => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get textStyle18 => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get textStyle20 => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get textStyle30 => TextStyle(
        fontSize: 30.sp,
        fontFamily: kGtSectraFine,
      );
}
