import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/styles_manager.dart';

class BookRating extends StatelessWidget {
  const BookRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.solidStar,
          size: 15,
          color: Color(0xffFFDD4F),),
        SizedBox(
          width: 6.3,
        ),
        Text('4.8',style: StylesManager.textStyle16,),
        SizedBox(
          width: 5,
        ),
        Opacity(
            opacity: 0.5,
            child: Text('(245)',style: StylesManager.textStyle14.copyWith(
              fontWeight: FontWeight.w600,
            ),
            ))
      ],
    );
  }
}
