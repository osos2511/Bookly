import 'package:bookly/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
Image.asset(AssetsManager.logo,height: 20,),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.magnifyingGlass,size: 26,)),
      ],
    );
  }
}
