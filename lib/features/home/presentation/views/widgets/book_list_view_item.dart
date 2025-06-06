import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles_manager.dart';
import 'book_rating.dart';

class BookListViewItem extends StatelessWidget {
  const BookListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).push(AppRouter.kBookDetailsView);
      },
      child: SizedBox(
        height: 125,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2.4/4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AssetsManager.listImg)),
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text('Harry Potter and the Goblet of Fire',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: StylesManager.textStyle20.copyWith(fontFamily: kGtSectraFine),)),
                  const SizedBox(
                    height: 3,
                  ),
                  Text('J.K.Rowling',style: StylesManager.textStyle14,),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text('19.99 €',style: StylesManager.textStyle20.copyWith(fontWeight: FontWeight.bold),),
                      Spacer(),
                      BookRating(),
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
