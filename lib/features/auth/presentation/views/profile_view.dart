import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../checkout/widgets/payment_tile.dart';
import '../widgets/profile_text_field.dart';

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

  final ValueNotifier<String?> _selectedImage = ValueNotifier<String?>(null);

  late AuthCubit authCubit;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage.value = image.path;
    }
  }

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);

    final user = authCubit.currentUser;
    if (user != null) {
      _name.text = user.name;
      _email.text = user.email;
      _address.text = user.address ?? '';
      _visa.text = user.visa ?? '';
    }

    authCubit.getProfileData();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    _visa.dispose();
    _selectedImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isGuest = authCubit.isGuest;

    if (isGuest) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Guest Mode')),
          const Gap(10),
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
    }

    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primary,
      onRefresh: () async {
        await authCubit.getProfileData();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthProfileUpdated) {
            AppSnackBar.showSuccess(
              context,
              'Profile updated successfully',
            );
          }

          if (state is AuthFailure) {
            AppSnackBar.showError(context, state.message);
          }

          if (state is AuthLogOut) {
            GoRouter.of(context).go(AppRoutePaths.loginView);
            AppSnackBar.showSuccess(context, 'Logout Success');
          }
        },
        builder: (context, state) {
          final user = authCubit.currentUser;

          if (state is AuthProfileData || state is AuthProfileUpdated) {
            final UserModel u = (state as dynamic).user;
            _name.text = u.name;
            _email.text = u.email;
            _address.text = u.address ?? '';
            _visa.text = u.visa ?? '';
          }

          final bool isLoading =
              (user == null) && (state is AuthLoading || state is AuthInitial);

          return GestureDetector(
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
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Column(
                      children: [
                        Center(
                          child: ValueListenableBuilder<String?>(
                            valueListenable: _selectedImage,
                            builder: (context, selectedImage, _) {
                              Widget child;
                              if (selectedImage != null) {
                                child = ClipOval(
                                  child: Image.file(
                                    File(selectedImage),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else if (user?.image != null &&
                                  user!.image!.isNotEmpty) {
                                child = ClipOval(
                                  child: Image.network(
                                    user!.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, err, builder) =>
                                    const Icon(Icons.person),
                                  ),
                                );
                              } else {
                                child = const Icon(Icons.person);
                              }

                              return Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                child: child,
                              );
                            },
                          ),
                        ),

                        const Gap(10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              onTap: pickImage,
                              text: user?.image == null
                                  ? 'Upload image'
                                  : 'change image',
                              width: 160,
                              height: 40,
                              borderRadius: 12,
                              color: Colors.white,
                              textColor: AppColors.primary,
                              horizontalPadding: 0,
                              verticalPadding: 0,
                              withIcon: true,
                              iconColor: AppColors.primary,
                              iconData: CupertinoIcons.camera,
                            ),
                            const Gap(6),
                            user?.image != null
                                ? CustomButton(
                              onTap: () {
                                _selectedImage.value = null;

                              },
                              text: 'remove image',
                              width: 160,
                              height: 40,
                              borderRadius: 12,
                              color: Colors.white,
                              textColor: AppColors.primary,
                              horizontalPadding: 4,
                              verticalPadding: 0,
                              withIcon: true,
                              iconColor: AppColors.primary,
                              iconData: CupertinoIcons.delete,
                            )
                                : const Gap(6),
                          ],
                        ),

                        const Gap(30),

                        ProfileTextField(controller: _name, labelText: 'Name'),
                        const Gap(25),
                        ProfileTextField(
                          controller: _email,
                          labelText: 'Email',
                        ),
                        const Gap(25),
                        ProfileTextField(
                          controller: _address,
                          labelText: 'Address',
                        ),

                        const Gap(20),
                        const Divider(),
                        const Gap(10),

                        user?.visa == null
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
                          user?.visa ?? '**** **** **** 0505',
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

                        const Gap(200),
                      ],
                    ),
                  ),
                ),
              ),
              bottomSheet: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ------- EDIT PROFILE BUTTON -------
                    GestureDetector(
                      onTap: () async {
                        await authCubit.updateProfileData(
                          name: _name.text.trim(),
                          email: _email.text.trim(),
                          address: _address.text.trim(),
                          image: _selectedImage.value,
                          visa: _visa.text.trim(),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: 120,
                          height: 20,
                          child: Center(
                            child: (state is AuthUpdateLoading)
                                ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Edit Profile',
                                  style: Styles.textStyle18.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ------- LOGOUT BUTTON -------
                    GestureDetector(
                      onTap: () async {
                        await authCubit.logout();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: 120,
                          height: 20,
                          child: Center(
                            child: (state is AuthLogOutLoading)
                                ? const CupertinoActivityIndicator(
                              color: AppColors.primary,
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Log out',
                                  style: Styles.textStyle18.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.logout_outlined,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
