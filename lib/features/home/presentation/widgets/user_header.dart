import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';


class UserHeader extends StatelessWidget {
  const UserHeader({super.key,  required this.name ,  this.profileImage});
final String name;
final String? profileImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              "assets/logo/logo.svg",
              color: AppColors.primary,
              height: 35,
            ),
            Gap(5),
            Text(
              'Hello, $name',
              style: Styles.textStyle16.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 35,
          backgroundColor: AppColors.primary,
          child: ClipOval(
            child: profileImage == null
                ? Icon(CupertinoIcons.person, color: Colors.white)
                : Image.network(
              profileImage!,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
            ),
          ),
        ),

      ],
    );
  }
}
