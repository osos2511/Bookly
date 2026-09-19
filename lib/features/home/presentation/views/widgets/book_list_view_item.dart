import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles_manager.dart';
import 'book_rating.dart';

class BookListViewItem extends StatelessWidget {
  const BookListViewItem({super.key, required this.bookModel});

  final Items bookModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kBookDetailsView);
      },
      child: SizedBox(
        height: 125.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBookImage(
              imageUrl: bookModel.volumeInfo?.imageLinks?.thumbnail ?? '',
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.volumeInfo?.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StylesManager.textStyle20
                        .copyWith(fontFamily: kGtSectraFine),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    bookModel.volumeInfo?.authors?.isNotEmpty == true
                        ? bookModel.volumeInfo!.authors![0]
                        : '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StylesManager.textStyle14,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        'Free',
                        style: StylesManager.textStyle20
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const BookRating(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
