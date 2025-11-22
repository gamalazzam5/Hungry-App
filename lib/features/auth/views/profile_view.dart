import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/widgets/profile_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../checkout/widgets/payment_tile.dart';
import '../data/repos/auth_repo.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();
  Future<void> getProfileData()async{

    try{
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch(e){
      String errMessage = 'Error in profile';
      if(e is ApiError){
        errMessage = e.message;
      }
      if(!mounted) return;
      AppSnackBar.showError(context, errMessage);
    }
  }

  @override
  void initState() {
    getProfileData().then((v){
      _name.text = userModel?.name??"";
      _email.text = userModel?.email??"";
      _address.text = userModel?.address??"";
    });
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor:Colors.white ,
      color: AppColors.primary,
      onRefresh: () async{

        await getProfileData();
      },
      child: GestureDetector(
       onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
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
              child: Skeletonizer(
                enabled: userModel==null,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: userModel?.image !=null && userModel!.image!.isNotEmpty?
      
                          DecorationImage(
                            image: NetworkImage(
                               userModel!.image!
                            ),
                          ):null,
                          color: Colors.grey.shade300,
                          border: Border.all(width: 2, color: Colors.white),
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
                    userModel?.visa==null?
                    ProfileTextField(controller: _visa, labelText: 'Visa Card',
                    keyboardType: TextInputType.number,
                    ):
      
                    PaymentTile(
                      titleColor: const Color(0xFF3C2F2F),
                      subTitleColor: AppColors.greyColor,
                      onTap: () {},
                      title: 'Debit card',
                      subTitle:userModel?.visa?? '**** **** **** 0505',
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
        ),
      ),
    );
  }
}
