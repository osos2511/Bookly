import 'package:flutter/material.dart';

import 'custom_appBar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          CustomAppBar(
          ),
          CustomListViewItem(),
        ],
      ),
    );
  }


}
class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


