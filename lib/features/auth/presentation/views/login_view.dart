import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_text_field.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/service_locator.dart';
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
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    authCubit = getIt<AuthCubit>();
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }

                            final regex = RegExp(
                              r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!regex.hasMatch(value.trim())) {
                              return 'Invalid email format';
                            }

                            return null;
                          },
                        ),

                        const Gap(10),

                        CustomTextFormField(
                          hintText: 'Password',
                          borderRadius: 6,
                          controller: passwordController,
                          isPassword: true,
                        ),

                        const Gap(25),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthAuthenticated ) {
                              GoRouter.of(context).go(AppRoutePaths.root);
                              AppSnackBar.showSuccess(context, 'Login Success');
                            } else if(state is AuthGuest){
                              GoRouter.of(context).go(AppRoutePaths.root);
                            }
                            else if (state is AuthFailure) {
                              AppSnackBar.showError(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return CupertinoActivityIndicator(
                                color: AppColors.primary,
                              );
                            } else {
                              return CustomAuthBtn(
                                color: AppColors.primary,
                                textColor: Colors.white,
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    authCubit.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login',
                              );
                            }
                          },
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
                          alignment: .centerRight,

                          child: TextButton(
                            onPressed: () {
                              authCubit.continueAsGuest();
                            },
                            child: Text(
                              'Continue as a Guest ?',
                              style: Styles.boldTextStyle16.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        Gap(150),
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
