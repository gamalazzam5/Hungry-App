import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_styles.dart';

import '../../../../core/constants/app_colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onAdd,
    this.onMin,
    this.onRemove,
    required this.number,
    this.isSkeleton = false,  this.isLoadingRemove = false,

  });

  final String image, text, desc;
  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRemove;
  final int number;
  final bool isSkeleton;
 final bool isLoadingRemove;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: isSkeleton
                ? Container(width: 75, height: 75, color: Colors.grey[300])
                : Image.network(image, width: 75, height: 75, fit: BoxFit.cover),
          ),

          const Gap(12),

          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [

                isSkeleton
                    ? Container(height: 14, width: double.infinity, color: Colors.grey[300])
                    : Text(text, style: Styles.boldTextStyle14, overflow: TextOverflow.ellipsis, maxLines: 1),

                const Gap(4),

                isSkeleton
                    ? Container(height: 12, width: 60, color: Colors.grey[300])
                    : Text(desc, style: Styles.textStyle12.copyWith(color: Colors.grey)),

                const Gap(8),

                Row(
                  children: [
                    _circleButton(CupertinoIcons.minus, onMin, isSkeleton),
                    const Gap(12),
                    isSkeleton
                        ? Container(height: 14, width: 14, color: Colors.grey[300])
                        : Text(number.toString(), style: Styles.textStyle16),
                    const Gap(12),
                    _circleButton(CupertinoIcons.add, onAdd, isSkeleton),
                  ],
                ),
              ],
            ),
          ),

          const Gap(10),

          /// ===== DELETE =====
          isSkeleton
              ? Container(width: 25, height: 25, color: Colors.grey[300])
              : GestureDetector(
            onTap: onRemove,
            child: isLoadingRemove? CupertinoActivityIndicator(color: AppColors.primary,): const Icon(CupertinoIcons.trash, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, Function()? action, bool skeleton) {
    return GestureDetector(
      onTap: skeleton ? null : action,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: skeleton ? Colors.grey[300] : AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: skeleton
            ? null
            : Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }
}
