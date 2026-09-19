import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBookDetailsAppBar extends StatelessWidget {
  const CustomBookDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close, size: 24.sp),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_checkout_outlined, size: 24.sp),
          ),
        ],
      ),
    );
  }
}
