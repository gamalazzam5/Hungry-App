import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/shared/custom_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.number,
  });

  final String image, title, desc;
  final Function()? onAdd;
  final Function()? onMinus;
  final Function()? onRemove;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Image.asset(image, height: 102, width: 110),
                Text(title, style: Styles.boldTextStyle16),
                Text(desc, style: Styles.textStyle16),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.add, color: Colors.white),
                      ),
                    ),
                    Gap(20),
                    SizedBox(
                        height: 25,
                        width: 25,

                        child: Center(child: Text("$number", style: Styles.boldTextStyle20))),
                    Gap(20),

                    GestureDetector(
                      onTap: onMinus,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.minus, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                CustomButton(
                  text: 'Remove',
                  borderRadius: 8,
                  horizontalPadding: 24,
                  verticalPadding: 10,
                  onTap: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
