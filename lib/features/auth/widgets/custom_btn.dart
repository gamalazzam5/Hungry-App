import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({super.key, required this.text, required this.onTap});
final VoidCallback onTap;
final String text;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.boldTextStyle16.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
