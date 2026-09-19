import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      child: Row(
        children: [
          Image.asset(
            AssetsManager.logo,
            height: 22.h,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSearchView);
            },
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
