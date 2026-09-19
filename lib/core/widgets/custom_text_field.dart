import 'package:bookly/core/utils/constants.dart';
import 'package:bookly/core/utils/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.enabled = true,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      style: StylesManager.textStyle16,
      cursorColor: kAccentColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: StylesManager.textStyle16.copyWith(
          color: Colors.white.withValues(alpha: 0.4),
        ),
        prefixIcon: Icon(prefixIcon, size: 20.sp),
        prefixIconColor: Colors.white.withValues(alpha: 0.6),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        errorStyle: StylesManager.textStyle14.copyWith(
          fontSize: 12.sp,
          color: kErrorColor,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        enabledBorder: _border(Colors.white.withValues(alpha: 0.25)),
        focusedBorder: _border(kAccentColor, width: 1.6),
        errorBorder: _border(kErrorColor),
        focusedErrorBorder: _border(kErrorColor, width: 1.6),
        disabledBorder: _border(Colors.white.withValues(alpha: 0.12)),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
