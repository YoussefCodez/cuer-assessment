import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/login_strings.dart';
import '../../view_model/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.isLoading,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
          _emailController.text.trim(),
          _passwordController.text,
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                labelText: LoginStrings.emailLabel,
                prefixIcon: Icon(Icons.email_outlined, size: 22.sp),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return LoginStrings.emailRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                labelText: LoginStrings.passwordLabel,
                prefixIcon: Icon(Icons.lock_outline, size: 22.sp),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return LoginStrings.passwordRequired;
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
                  LoginStrings.loginButton,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
