import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/auth/widgets/custom_btn.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/shared/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late TextEditingController emailController;

  late TextEditingController nameController;

  late TextEditingController passwordController;

  late TextEditingController confirmPassController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();
    nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(100),
                SvgPicture.asset('assets/logo/logo.svg'),
                Gap(60),
                CustomTextFormField(
                  hintText: 'Name',
                  borderRadius: 6,
                  controller: nameController,
                ),
                Gap(10),
                CustomTextFormField(
                  hintText: 'Email Address',
                  borderRadius: 6,
                  controller: emailController,
                ),
                Gap(10),
                CustomTextFormField(
                  hintText: 'Password',
                  borderRadius: 6,
                  controller: passwordController,
                  isPassword: true,
                ),
                Gap(10),
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  borderRadius: 6,
                  controller: confirmPassController,
                  isPassword: true,
                ),
                Gap(25),
                CustomAuthBtn( onTap: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint("Success");
                  }
                }, text: 'Sign up'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
