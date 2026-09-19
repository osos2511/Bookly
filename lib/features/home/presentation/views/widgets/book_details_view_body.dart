import 'package:bookly/core/utils/styles_manager.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly/features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'books_action.dart';
import 'custom_book_details_appBar.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const CustomBookDetailsAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: const CustomBookImage(imageUrl: ''),
                ),
                SizedBox(height: 36.h),
                Text(
                  'The Jungle Book',
                  textAlign: TextAlign.center,
                  style: StylesManager.textStyle30.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    'Rudyard Kipling',
                    style: StylesManager.textStyle18.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                const BookRating(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 32.h),
                const BooksAction(),
                Expanded(child: SizedBox(height: 40.h)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'You can also like',
                    style: StylesManager.textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                const SimilarBooksListView(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
