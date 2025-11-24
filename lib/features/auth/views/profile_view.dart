import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/widgets/profile_text_field.dart';
import 'package:image_picker/image_picker.dart';
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
  String? selectedImage;
  bool isLoadingUpdate = false;
  bool isLoadingLogOut = false;
  bool isGuest = false;

  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) setState(() => userModel = user);
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errMessage = 'Error in profile';
      if (e is ApiError) {
        errMessage = e.message;
      }
      if (!mounted) return;
      AppSnackBar.showError(context, errMessage);
    }
  }

  ///update profile
  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        image: selectedImage,
        visa: _visa.text.trim(),
      );
      if (!mounted) return;
      AppSnackBar.showSuccess(context, 'Profile updated successfully');
      setState(() {
        isLoadingUpdate = false;
        userModel = user;
      });

      await getProfileData();
    } catch (e) {
      setState(() => isLoadingUpdate = false);
      String errorMsg = 'Failed to update profile';
      if (e is ApiError) errorMsg = e.message;
      if (!mounted) return;
      AppSnackBar.showError(context, errorMsg);
    }
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image.path;
      });
    }
  }

  Future<void> logout() async {
    try {
      setState(() => isLoadingLogOut = true);
      await authRepo.logout();
      setState(() => isLoadingLogOut = false);
      if (!mounted) return;
      GoRouter.of(context).go(AppRoutePaths.loginView);
    } catch (e) {
      setState(() => isLoadingLogOut = false);
      String errorMsg = 'Failed to logout';
      if (e is ApiError) errorMsg = e.message;
      if (!mounted) return;
      AppSnackBar.showError(context, errorMsg);
    }
  }

  @override
  void initState() {
    autoLogin();
    getProfileData().then((v) {
      _name.text = userModel?.name ?? "";
      _email.text = userModel?.email ?? "";
      _address.text = userModel?.address ?? "";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          await getProfileData();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                  enabled: userModel == null,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,

                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: selectedImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    File(selectedImage!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : (userModel?.image != null &&
                                    userModel!.image!.isNotEmpty)
                              ? ClipOval(
                                  child: Image.network(
                                    userModel!.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, err, builder) =>
                                        Icon(Icons.person),
                                  ),
                                )
                              : Icon(Icons.person),
                        ),
                      ),

                      Gap(10),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          CustomButton(
                            onTap: pickImage,
                            text: userModel?.image == null
                                ? 'Upload image'
                                : 'change image',
                            width: 150,
                            height: 40,
                            borderRadius: 12,
                            color: Colors.white,
                            textColor: AppColors.primary,
                            horizontalPadding: 4,
                            verticalPadding: 0,
                            profileEdit: true,
                            iconData: CupertinoIcons.camera,
                          ),
                          Gap(6),
                          userModel?.image != null
                              ? CustomButton(
                                  onTap: () {},
                                  text: 'remove image',
                                  width: 155,
                                  height: 40,
                                  borderRadius: 12,
                                  color: Colors.white,
                                  textColor: AppColors.primary,
                                  horizontalPadding: 4,
                                  verticalPadding: 0,
                                  profileEdit: true,
                                  iconData: CupertinoIcons.delete,
                                )
                              : Gap(6),
                        ],
                      ),
                      Gap(30),
                      ProfileTextField(controller: _name, labelText: 'Name'),
                      Gap(25),
                      ProfileTextField(controller: _email, labelText: 'Email'),
                      Gap(25),
                      ProfileTextField(
                        controller: _address,
                        labelText: 'Address',
                      ),
                      Gap(20),
                      Divider(),
                      Gap(10),
                      userModel?.visa == null
                          ? ProfileTextField(
                              controller: _visa,
                              labelText: 'Add Visa Card',
                              keyboardType: TextInputType.number,
                            )
                          : PaymentTile(
                              titleColor: const Color(0xFF3C2F2F),
                              subTitleColor: AppColors.greyColor,
                              onTap: () {},
                              title: 'Debit card',
                              subTitle:
                                  userModel?.visa ?? '**** **** **** 0505',
                              icon: 'assets/icon/visa.png',
                              tileColor: const Color(0xFFF3F4F6),
                              value: 'Visa',
                              groupValue: 'Visa',
                              onChanged: (v) {},
                              trailing: Text(
                                'Default',
                                style: Styles.boldTextStyle16,
                              ),
                            ),
                      Gap(200),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  GestureDetector(
                    onTap: updateProfileData,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          isLoadingUpdate
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Edit Profile',
                                  style: Styles.textStyle18.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                          Gap(5),
                          Icon(Icons.edit_outlined, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: logout,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: isLoadingLogOut
                          ? Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : Row(
                              children: [
                                Text(
                                  'Log out',
                                  style: Styles.textStyle18.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                Gap(5),
                                Icon(
                                  Icons.logout_outlined,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (isGuest) {
      return Column(
        mainAxisAlignment: .center,
        children: [
          Center(child: Text('Guest Mode')),
          Gap(10),
          CustomButton(
            onTap: () {
              GoRouter.of(context).go(AppRoutePaths.loginView);
            },
            text: 'Back to Login',
            width: 150,
            height: 40,
            borderRadius: 12,
            color: AppColors.primary,
            textColor: Colors.white,
            horizontalPadding: 6,
            verticalPadding: 0,
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
