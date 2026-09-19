import 'package:bookly/core/utils/constants.dart';
import 'package:bookly/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: '19.99 €',
              fontSize: 18,
              textColor: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                topLeft: Radius.circular(16.r),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: CustomButton(
              fontSize: 16,
              text: 'Free Preview',
              textColor: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              backgroundColor: kAccentColor,
            ),
          ),
        ],
      ),
    );
  }
}
