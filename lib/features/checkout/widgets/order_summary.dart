import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key, required this.title, required this.price,  this.isBold= false,  this.isSmall = false});
final String title,price;
final bool isBold,isSmall;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            title,
            style: Styles.textStyle16.copyWith(
              fontSize: isSmall?12:16,
              color:isBold? null :  AppColors.greyColor,
              fontWeight:isBold? FontWeight.bold:  FontWeight.w400,
            ),
          ),
          Text(
            '\$$price',
            style: Styles.textStyle16.copyWith(
              fontSize: isSmall?12:16,
              color:isBold? null : AppColors.greyColor,
              fontWeight: isBold? FontWeight.bold: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
