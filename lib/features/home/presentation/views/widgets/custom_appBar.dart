import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: Row(
        children: [
      Image.asset(AssetsManager.logo,height: 20,),
          Spacer(),
          IconButton(onPressed: (){
            GoRouter.of(context).push(AppRouter.kBookDetailsView);
          }, icon: Icon(FontAwesomeIcons.magnifyingGlass,size: 23,)),
        ],
      ),
    );
  }
}
