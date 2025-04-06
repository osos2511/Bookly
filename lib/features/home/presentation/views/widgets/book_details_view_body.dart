import 'package:bookly/core/utils/styles_manager.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

import 'custom_book_details_appBar.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomBookDetailsAppBar(),
          Padding(
              padding:EdgeInsets.symmetric(horizontal: width*0.2),
              child: CustomBookImage()),
          SizedBox(
            height: 43,
          ),
          Text('The Jungle Book',style: StylesManager.textStyle30.copyWith(
            fontWeight: FontWeight.bold
          ),),
          SizedBox(
            height: 6,
          ),
          Opacity(
            opacity: 0.7,
            child: Text('Rudyard Kipling',style: StylesManager.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500
            ),),
          ),
        ],
      ),
    );
  }
}


