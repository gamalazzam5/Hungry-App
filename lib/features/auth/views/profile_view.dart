import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/features/auth/widgets/profile_text_field.dart';

import '../../checkout/widgets/payment_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void initState() {
    _name.text = 'Gamal Azzam';
    _email.text = 'gamalazzam05@gmail.com';
    _address.text = ' 20 Samannud Egypt';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset('assets/icon/settings.svg'),
          ),
        ],
        leading: GestureDetector(
          onTap: () => context.pop(),

          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'data:image/png;base64,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',
                      ),
                    ),
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                ),
              ),
              Gap(30),
              ProfileTextField(controller: _name, labelText: 'Name'),
              Gap(25),
              ProfileTextField(controller: _email, labelText: 'Email'),
              Gap(25),
              ProfileTextField(controller: _address, labelText: 'Address'),
              Gap(20),
              Divider(),
              Gap(10),
              PaymentTile(
                titleColor: const Color(0xFF3C2F2F),
                subTitleColor: AppColors.greyColor,
                onTap: () {},
                title: 'Debit card',
                subTitle: '3566 **** **** 0505',
                icon: 'assets/icon/visa.png',
                tileColor: const Color(0xFFF3F4F6),
                value: 'Visa',
                groupValue: 'Visa',
                onChanged: (v) {},
                trailing: Text('Default', style: Styles.boldTextStyle16),
              ),
              Gap(200)
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white
              ,
          borderRadius: BorderRadius.circular(12),
        ),
        child:Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text('Edit Profile',style: Styles.textStyle18.copyWith(color: Colors.white),),
                  Gap(5),
                  Icon(Icons.edit_outlined,color: Colors.white,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(

                children: [
                  Text('Log out',style: Styles.textStyle18.copyWith(color: AppColors.primary),),
                  Gap(5),
                  Icon(Icons.logout_outlined,color: AppColors.primary,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
