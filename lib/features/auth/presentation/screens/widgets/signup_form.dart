import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/signup_strings.dart';
import '../../../../../config/utils/auth_regx.dart';
import '../../view_model/auth_cubit.dart';

class SignupForm extends StatefulWidget {
  final bool isLoading;

  const SignupForm({
    super.key,
    required this.isLoading,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 20.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                labelText: SignupStrings.nameLabel,
                prefixIcon: Icon(Icons.person_outline, size: 22.sp),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return SignupStrings.nameRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                labelText: SignupStrings.emailLabel,
                prefixIcon: Icon(Icons.email_outlined, size: 22.sp),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return SignupStrings.emailRequired;
                }
                if (!AuthRegx.isValidEmail(val.trim())) {
                  return SignupStrings.emailInvalid;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                labelText: SignupStrings.passwordLabel,
                prefixIcon: Icon(Icons.lock_outline, size: 22.sp),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 22.sp,
                    color: AppColors.textSecondary,
                  ),
                  tooltip: _isPasswordVisible
                      ? SignupStrings.hidePassword
                      : SignupStrings.showPassword,
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return SignupStrings.passwordRequired;
                }
                if (val.length < 6) {
                  return SignupStrings.passwordMinLength;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                labelText: SignupStrings.confirmPasswordLabel,
                prefixIcon: Icon(Icons.lock_outline, size: 22.sp),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 22.sp,
                    color: AppColors.textSecondary,
                  ),
                  tooltip: _isConfirmPasswordVisible
                      ? SignupStrings.hidePassword
                      : SignupStrings.showPassword,
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return SignupStrings.confirmPasswordRequired;
                }
                if (val != _passwordController.text) {
                  return SignupStrings.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            SizedBox(height: 32.h),
            if (widget.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  SignupStrings.signUpButton,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
