import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: AspectRatio(
        aspectRatio: 2.6 / 4,
        child: NetworkImageWidget(imageUrl: imageUrl),
      ),
    );
  }
}

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.error,
        size: 24.sp,
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            height: 24.r,
            width: 24.r,
            child: CircularProgressIndicator(strokeWidth: 2.r),
          ),
        );
      },
    );
  }
}
