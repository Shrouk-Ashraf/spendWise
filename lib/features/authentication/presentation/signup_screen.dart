import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';
import 'package:spendwise/core/utils/components/default_button.dart';
import 'package:spendwise/core/utils/components/email_text_field.dart';
import 'package:spendwise/core/utils/components/password_text_field.dart';
import 'package:spendwise/features/authentication/presentation/cubit/auth_cubit.dart';

import '../../../config/di/di.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An error occurred'),
            ),
          );
        } else if (state.status == AuthStatus.success) {
          EasyLoading.dismiss();
          // Navigate to the main app screen or dashboard
        } else if(state.status == AuthStatus.loading) {

          EasyLoading.show();
        }else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.text24BoldDarkBlue,
                        ),
                      ),
                      Gap(8),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign up to get started with spendWise',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.text16RegularLightGray,
                        ),
                      ),
                      Gap(32),
                      // ── Email Field ─────────────────────────────────
                      Text(
                        "Email",
                        style: AppTextStyles.text14Font500MediumGray,
                      ),
                      Gap(8),
                      EmailField(controller: _emailController),

                      Gap(16),

                      // ── Password Field ──────────────────────────────
                      Text(
                        "Password",
                        style: AppTextStyles.text14Font500MediumGray,
                      ),
                      Gap(8),
                      PasswordField(controller: _passwordController),

                      Gap(16),

                      // ── Submit Button ───────────────────────────────
                      DefaultButton(
                        label: 'Sign Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthCubit.get(context).signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),

                      const Gap(32),


                      // ── Toggle Sign Up / Sign In ────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: AppTextStyles.text14RegularLightGray,
                          ),
                          const Gap(4),
                          TextButton(
                            onPressed: () {
                              context.goNamed(AppRoutes.login);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign In',
                              style: AppTextStyles.text14Font500Primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
