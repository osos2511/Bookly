import 'package:flutter/material.dart';

import '../../../../../core/utils/assets_manager.dart';

class CustomFeaturedBooksItem extends StatelessWidget {
  const CustomFeaturedBooksItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5/4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AssetsManager.listImg)),
        ),
      ),
    );
  }
}
