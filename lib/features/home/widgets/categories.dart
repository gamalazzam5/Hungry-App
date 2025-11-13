import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class Categories extends StatefulWidget {
   Categories({super.key, required this.category, required this.selectedIndex});
  final List category;
  final int selectedIndex;
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late int selectedIndex ;

  @override
  initState(){
    selectedIndex = widget.selectedIndex;
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.primary
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 30, vertical: 16),
              child: Text(
                widget.category[index],
                style: Styles.boldTextStyle16.copyWith(
                  color: selectedIndex == index
                      ? Colors.white
                      : AppColors.greyColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
