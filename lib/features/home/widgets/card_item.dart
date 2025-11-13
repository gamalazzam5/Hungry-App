import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../core/constants/app_styles.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.image, required this.text, required this.desc, required this.rate, required this.isSelected});
final String image,text,desc,rate;
final bool isSelected;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  late bool isSelected;
  @override
  void initState() {
       isSelected = widget.isSelected;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.image,width: 170,),
              Gap(8),
              Text(widget.text,style: Styles.boldTextStyle16,),
              Text(widget.desc),
              Row(
                children: [
                  Text("⭐ ${widget.rate}"),
                  Spacer(),
                  GestureDetector(
                      onTap: (){
                        setState(() => isSelected = !isSelected);
                      },
                      child: Icon(isSelected == true?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: AppColors.primary,))
                ],
              ),
            ]
        ),
      ),
    );
  }
}
