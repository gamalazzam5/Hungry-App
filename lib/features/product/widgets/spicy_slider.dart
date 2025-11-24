import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged, required this.image});
final double value;
final String image;
final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Image.network(image, width: 120),
        Column(
          children: [
            Text(
              'Customize Your Burger\n to Your Tastes.\n Ultimate Experience',
            ),
            Slider(
              value: value,
              onChanged: onChanged,
              inactiveColor: Colors.grey.shade300,
              activeColor: AppColors.primary,
              min: 0,
              max: 1,
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [Text('🥶'), Gap(100), Text('🌶️')],
            ),
          ],
        ),
      ],
    );
  }
}
