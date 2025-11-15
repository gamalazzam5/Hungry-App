import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../widgets/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
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
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(200),
              SvgPicture.asset('assets/logo/logo.svg'),
              const Gap(6),
              Text(
                'Welcome to our Food App',
                style: Styles.textStyle16.copyWith(color: Colors.white),
              ),
              const Gap(70),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(30),
                        CustomTextFormField(
                          hintText: 'Email Address',
                          borderRadius: 6,
                          controller: emailController,
                        ),
                    
                        const Gap(10),
                    
                        CustomTextFormField(
                          hintText: 'Password',
                          borderRadius: 6,
                          controller: passwordController,
                          isPassword: true,
                        ),
                    
                        const Gap(25),
                    
                        CustomAuthBtn(
                          color: AppColors.primary,
                          textColor: Colors.white,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              debugPrint("Success");
                            }
                          },
                          text: 'Login',
                        ),
                    
                        const Gap(10),
                    
                        CustomAuthBtn(
                          onTap: () {
                            context.push(AppRoutePaths.signupView);
                          },
                          text: 'Create Account',
                          color: Colors.grey.shade300,
                          textColor: AppColors.primary,
                        ),
                     Align(
                       alignment: Alignment.centerRight,

                       child: TextButton(

                           onPressed: (){
                         GoRouter.of(context).push(AppRoutePaths.root);
                       } , child: Text('Continue as a Guest ?',style: Styles.boldTextStyle16.copyWith(color: AppColors.primary),)),
                     )
,                     Gap(150)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
