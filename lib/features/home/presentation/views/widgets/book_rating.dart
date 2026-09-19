import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles_manager.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          FontAwesomeIcons.solidStar,
          size: 14.sp,
          color: kRatingColor,
        ),
        SizedBox(width: 6.w),
        Text(
          '4.8',
          style: StylesManager.textStyle16,
        ),
        SizedBox(width: 4.w),
        Opacity(
          opacity: 0.5,
          child: Text(
            '(2390)',
            style: StylesManager.textStyle14.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
