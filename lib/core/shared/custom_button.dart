import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.borderRadius = 16,
    this.horizontalPadding = 20,
    this.verticalPadding = 12,
    this.width,
    this.color,
    this.height,
    this.textColor,
    this.withIcon = false,
    this.iconData,
    this.iconColor,
    this.isLoading = false,
  });

  final Function()? onTap;
  final String text;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double? width;
  final Color? color;
  final double? height;
  final Color? textColor;
  final bool withIcon;
  final IconData? iconData;
  final Color? iconColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: withIcon
              ? Stack(
            alignment: Alignment.center,
            children: [
              if (isLoading)
                const CupertinoActivityIndicator(color: Colors.white, radius: 12),

              AnimatedOpacity(
                opacity: isLoading ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: Styles.textStyle18.copyWith(
                        color: textColor ?? Colors.white,
                      ),
                    ),
                    const Gap(8),
                    Icon(iconData, color: iconColor ?? Colors.white),
                  ],
                ),
              ),
            ],
          )
              : Text(
            text,
            style: Styles.textStyle18.copyWith(
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
