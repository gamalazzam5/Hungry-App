import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton( {super.key, required this.text, this.onTap,this.borderRadius =16,  this.horizontalPadding = 20,  this.verticalPadding =12,});
final Function()? onTap;
final String text;
  final double borderRadius ;
  final double horizontalPadding ;
  final double verticalPadding ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          text,
          style: Styles.textStyle18.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
