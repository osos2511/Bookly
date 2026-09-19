import 'package:flutter/material.dart';

import 'custom_book_image.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height*0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 5),
            child: CustomBookImage(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6z0gQ1u2t9w7q5w5z6w5z6w5z6w5z6w5z6w&s',
            ),
          );
        },),
    );
  }
}
