import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_text_field.dart';

import '../../../core/constants/app_colors.dart';
import '../widgets/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;

  late TextEditingController passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Gap(100),
                    SvgPicture.asset('assets/logo/logo.svg'),
                    Gap(10),
                    Text(
                      'Welcome Back, Discover The Fast Food',
                      style: Styles.textStyle14.copyWith(color: Colors.white),
                    ),
                    Gap(40),
                    CustomTextFormField(
                      hintText: 'Email Address',
                      borderRadius: 6,
                      controller: emailController,
                    ),
                    Gap(20),
                    CustomTextFormField(
                      hintText: 'Password',
                      borderRadius: 6,
                      controller: passwordController,
                      isPassword: true,
                    ),
                    Gap(30),
                    CustomAuthBtn(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint("Success");
                        }
                      },
                      text: 'Login',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
