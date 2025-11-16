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
                         'https://avatars.githubusercontent.com/u/166455869?v=4'
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
