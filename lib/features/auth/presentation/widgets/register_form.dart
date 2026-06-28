import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/theme/app_colors.dart';
import 'package:travel_planner/core/theme/app_text_styles.dart';
import 'package:travel_planner/core/widgets/custom_button.dart';
import 'package:travel_planner/core/widgets/custom_text_field.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Họ và tên',
            hintText: 'Nhập họ và tên',
            prefixIcon: Icons.person_outline_rounded,
            controller: _nameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Email',
            hintText: 'Nhập email',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Mật khẩu',
            hintText: 'Nhập mật khẩu',
            prefixIcon: Icons.lock_outlined,
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Xác nhận mật khẩu',
            hintText: 'Nhập lại mật khẩu',
            prefixIcon: Icons.lock_outline_rounded,
            controller: _confirmPasswordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: authState.isLoading ? 'Đang tạo tài khoản...' : 'Tạo tài khoản',
            onPressed: authState.isLoading
                ? null
                : () async {
                    final name = _nameController.text.trim();
                    final email = _emailController.text.trim();
                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;

                    if (name.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Vui lòng nhập đủ thông tin"),
                        ),
                      );
                      return;
                    }
                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Mật khẩu không khớp"),
                        ),
                      );
                      return;
                    }
                    final success = await ref.read(authProvider.notifier).register(name, email, password);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Đăng ký thành công! Vui lòng đăng nhập."),
                          backgroundColor: Colors.green, // AppColors.success
                        ),
                      );
                      Navigator.of(context).pop(); // Chuyển về trang đăng nhập
                    }
                  },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đã có tài khoản? ',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Đăng nhập',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
