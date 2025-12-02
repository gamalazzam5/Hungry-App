import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({super.key, required this.text, required this.onTap, this.color, this.textColor});
final VoidCallback onTap;
final String text;
final Color? color;
final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color ??Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.white
          )
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.boldTextStyle16.copyWith(
              color: textColor ?? AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
