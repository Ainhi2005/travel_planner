import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/routes/app_path.dart';
import 'package:travel_planner/core/theme/app_colors.dart';
import 'package:travel_planner/core/theme/app_text_styles.dart';
import 'package:travel_planner/core/widgets/custom_button.dart';
import 'package:travel_planner/core/widgets/custom_text_field.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();

  // Thêm lại biến này để ô Checkbox có thể tick chọn được
  bool _isRememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    // Đẩy dữ liệu qua provider để gọi API (không xử lý gì cái biến _isRememberMe cả)
    ref.read(authProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.background,
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
          // 1. Ô nhập số điện thoại cơ bản
          CustomTextField(
            label: 'Nhập email',
            hintText: 'Nhập email',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          
          // 2. Ô nhập mật khẩu
          CustomTextField(
            label: 'Mật khẩu',
            hintText: 'Nhập mật khẩu',
            prefixIcon: Icons.lock_outlined,
            controller: _passwordController,
            isPassword: true,
            rightLabelWidget: GestureDetector(
              onTap: () {
                // Xử lý quên mật khẩu sau này
              },
              child: Text(
                'Quên mật khẩu?',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 3. UI Checkbox "Nhớ mật khẩu" (Bấm được nhưng không xử lý logic)
          Row(
            children: [
              Checkbox(
                value: _isRememberMe,
                onChanged: (value) {
                  setState(() {
                    _isRememberMe = value ?? false;
                  });
                },
              ),
              const Text("Nhớ mật khẩu"),
            ],
          ),
          const SizedBox(height: 32),

          // 4. Nút Đăng nhập
          CustomButton(
            text: authState.isLoading ? 'Đang đăng nhập...' : 'Đăng nhập',
            onPressed: authState.isLoading ? null : _onLoginPressed,
          ),
          const SizedBox(height: 24),
          
          // 5. Dòng Đăng ký tài khoản
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản? ',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () => context.push(AppPath.register),
                child: Text(
                  'Đăng ký',
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
