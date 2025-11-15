import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routes/app_router.dart';
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

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
       backgroundColor: AppColors.primary,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(200),
                SvgPicture.asset(
                  'assets/logo/logo.svg',

                ),
                Gap(6),
                Text('Welcome to our Food App',style: Styles.textStyle16.copyWith(color: Colors.white),),
                Gap(70),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )

                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gap(30),
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
                      
                          Gap(25),
                          CustomAuthBtn(
                            color: AppColors.primary,
                            textColor: Colors.white,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                debugPrint("Success");
                              }
                            },
                            text: 'Sign up',
                          ),
                          Gap(10),
                          CustomAuthBtn(
                            onTap: () {
                           GoRouter.of(context).push(AppRoutePaths.loginView);
                            },
                            text: 'Go to Login',
                         color: Colors.grey.shade300,
                      
                            textColor: AppColors.primary,
                          ),
                          Gap(200)
                        ],
                      ),
                    ),
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
