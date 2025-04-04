import 'package:flutter/material.dart';

import 'custom_featured_books_item.dart';

class CustomFeaturedBooksListView extends StatelessWidget {
  const CustomFeaturedBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomFeaturedBooksItem(),
          );
        },),
    );
  }
}
