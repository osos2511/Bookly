import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
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
        height: 125,
        child: Row(
          children: [
            CustomBookImage(
                imageUrl: bookModel.volumeInfo?.imageLinks?.thumbnail ?? ''),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        bookModel.volumeInfo?.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: StylesManager.textStyle20
                            .copyWith(fontFamily: kGtSectraFine),
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    bookModel.volumeInfo?.authors?.isNotEmpty == true
                        ? bookModel.volumeInfo!.authors![0]
                        : '',
                    style: StylesManager.textStyle14,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
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
