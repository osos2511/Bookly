import 'package:bookly/core/utils/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'newest_books_listView.dart';
import 'custom_appBar.dart';
import 'custom_featured_book_listView.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                const CustomFeaturedBooksListView(),
                SizedBox(height: 24.h),
                Text('Newest Books', style: StylesManager.textStyle18),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: NewestBooksListView(),
          ),
        ],
      ),
    );
  }
}
