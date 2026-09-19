import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/assets_manager.dart';
import 'package:bookly/core/utils/constants.dart';
import 'package:bookly/core/utils/styles_manager.dart';
import 'package:bookly/core/utils/validators.dart';
import 'package:bookly/core/widgets/custom_button.dart';
import 'package:bookly/core/widgets/custom_text_field.dart';
import 'package:bookly/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    context.read<LoginCubit>().signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  void _onForgotPassword() {
    FocusScope.of(context).unfocus();

    final emailError = Validators.email(_emailController.text);
    if (emailError != null) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
      _showSnackBar(
        'Enter your email address first, then tap "Forgot Password?".',
        isError: true,
      );
      return;
    }

    context
        .read<LoginCubit>()
        .sendPasswordResetEmail(email: _emailController.text);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: StylesManager.textStyle14),
          backgroundColor: isError ? kErrorColor : kAccentColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          GoRouter.of(context).go(AppRouter.kHomeView);
        } else if (state is LoginFailure) {
          _showSnackBar(state.errorMessage, isError: true);
        } else if (state is PasswordResetSent) {
          _showSnackBar('Password reset link sent to ${state.email}.');
        }
      },
      builder: (context, state) {
        final isBusy = state is LoginLoading || state is PasswordResetLoading;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.h),
                  Image.asset(AssetsManager.logo, height: 56.h),
                  SizedBox(height: 40.h),
                  Text(
                    'Welcome Back',
                    style: StylesManager.textStyle30.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      'Sign in to continue reading',
                      style: StylesManager.textStyle16,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                    enabled: !isBusy,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    validator: Validators.password,
                    enabled: !isBusy,
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword,
                      ),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isBusy ? null : _onForgotPassword,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: StylesManager.textStyle14.copyWith(
                          color: kAccentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: 'Login',
                    fontSize: 16,
                    backgroundColor: kAccentColor,
                    textColor: Colors.white,
                    isLoading: state is LoginLoading,
                    onPressed: isBusy ? null : _submit,
                  ),
                  SizedBox(height: 32.h),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4.w,
                    children: [
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          "Don't have an account?",
                          style: StylesManager.textStyle14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showSnackBar('Sign up is coming soon.'),
                        child: Text(
                          'Sign Up',
                          style: StylesManager.textStyle14.copyWith(
                            color: kAccentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
