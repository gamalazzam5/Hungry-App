import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton( {super.key, required this.text, this.onTap,this.borderRadius =16,  this.horizontalPadding = 20,  this.verticalPadding =12, this.width, this.color, this.height, this.textColor, this.profileEdit = false,this.iconData,});
final Function()? onTap;
final String text;
  final double borderRadius ;
  final double horizontalPadding ;
  final double verticalPadding ;
  final double? width;
  final Color? color;
  final double? height;
  final Color? textColor;
  final bool profileEdit;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: profileEdit? Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                text,
                style: Styles.textStyle18.copyWith(
                  color: textColor?? Colors.white,
                ),
              ),

              Icon(iconData, color:  AppColors.primary),

            ],
          ):Text(
            text,
            style: Styles.textStyle18.copyWith(
              color: textColor?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
