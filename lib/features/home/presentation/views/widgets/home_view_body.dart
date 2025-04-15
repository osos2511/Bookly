import 'package:bookly/core/utils/styles_manager.dart';
import 'package:flutter/material.dart';
import 'newest_books_listView.dart';
import 'custom_appBar.dart';
import 'custom_featured_book_listView.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12, left: 12),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                CustomFeaturedBooksListView(),
                SizedBox(height: 16),
                Text('Newest Books', style: StylesManager.textStyle18),
                SizedBox(height: 16),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: NewestBooksListView(),
          )
        ],
      ),
    );
  }
}
