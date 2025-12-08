import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../../core/constants/app_styles.dart';


class PaymentTile extends StatelessWidget {
  const  PaymentTile({
    super.key,
    required this.title,
    required this.tileColor,
    required this.icon,
    this.subTitle, required this.value, required this.groupValue, required this.onChanged, required this.onTap, this.titleColor, this.subTitleColor, this.trailing,
  });

  final String title;
  final Color tileColor;
  final String icon;
  final String? subTitle;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? subTitleColor;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ,
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: subTitle == null ? 12 : 4),
      tileColor: tileColor,
      title: Text(
        title,
        style: Styles.textStyle16.copyWith(color:titleColor?? Colors.white),
      ),
      subtitle: subTitle != null ? Text(subTitle!,style: Styles.textStyle14.copyWith(color: subTitleColor??Colors.white),) : null,
      leading: Image.asset(icon, width: 72, height: 72),
      trailing:trailing?? Radio<String>(
        value: value,
        groupValue: groupValue,
        activeColor: Colors.white,
        onChanged: onChanged,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
