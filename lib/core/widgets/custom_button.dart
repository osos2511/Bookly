import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.fontSize,required this.text, this.borderRadius,required this.backgroundColor,required this.textColor});
final Color backgroundColor;
final Color textColor;
final BorderRadius? borderRadius;
final String text;
final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius??BorderRadius.circular(12),
            )
          ),
          onPressed: (){}, child: Text(text,style: TextStyle(
        color:textColor,
        fontWeight: FontWeight.w900,
        fontSize: fontSize
      ),)),
    );
  }
}
