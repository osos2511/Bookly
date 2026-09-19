import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: SizedBox(
          height: 32.r,
          width: 32.r,
          child: CircularProgressIndicator(strokeWidth: 2.5.r),
        ),
      ),
    );
  }
}
