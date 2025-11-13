import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_styles.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.image, required this.text, required this.desc, required this.rate});
final String image,text,desc,rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image,width: 170,),
              Gap(8),
              Text(text,style: Styles.boldTextStyle16,),
              Text(desc),
              Text("⭐ $rate"),
            ]
        ),
      ),
    );
  }
}
