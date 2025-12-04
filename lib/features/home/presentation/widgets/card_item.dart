import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';

class CardItem extends StatefulWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
    required this.isSelected,
  });

  final String image, text, desc, rate;
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
    return AspectRatio(
      aspectRatio: 0.55,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                flex: 3,
                child: Center(
                  child: Image.network(
                    widget.image,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Gap(10),

              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.boldTextStyle14.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                    Text(
                      widget.desc,
                      maxLines:2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle12.copyWith(
                        color: Colors.black54,
                      ),
                    ),

                    Spacer(),

                    Row(
                      children: [
                        Text("⭐ ${widget.rate}", style: Styles.boldTextStyle14),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() => isSelected = !isSelected);
                          },
                          child: Icon(
                            isSelected
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
