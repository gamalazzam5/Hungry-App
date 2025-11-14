import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../core/constants/app_styles.dart';

class PaymentTile extends StatelessWidget {
  const  PaymentTile({
    super.key,
    required this.title,
    required this.tileColor,
    required this.icon,
    this.subTitle, required this.value, required this.groupValue, required this.onChanged, required this.onTap,
  });

  final String title;
  final Color tileColor;
  final String icon;
  final String? subTitle;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ,
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: subTitle == null ? 16: 10),
      tileColor: tileColor,
      title: Text(
        title,
        style: Styles.textStyle20.copyWith(color: Colors.white),
      ),
      subtitle: subTitle != null ? Text(subTitle!,style: Styles.textStyle14.copyWith(color: Colors.white),) : null,
      leading: Image.asset(icon, width: 72, height: 72),
      trailing: Radio<String>(
        value: value,
        groupValue: groupValue,
        activeColor: Colors.white,
        onChanged: onChanged,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
