import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/shared/custom_button.dart';


Widget successDialog(BuildContext context) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 180),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha:.4),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: const Icon(CupertinoIcons.check_mark, color: Colors.white, size: 30),
            ),
            const Gap(10),
            Text(
              'Success!',
              style: Styles.boldTextStyle24.copyWith(color: AppColors.primary, fontSize: 30),
            ),
            const Gap(8),
            Text(
              'Your payment was successful\nReceipt sent to your email.',
              textAlign: TextAlign.center,
              style: Styles.textStyle12.copyWith(color: Colors.grey.shade500),
            ),
            const Gap(20),
            CustomButton(text: "Close", onTap: () => Navigator.pop(context), width: 200),
          ],
        ),
      ),
    ),
  );
}
