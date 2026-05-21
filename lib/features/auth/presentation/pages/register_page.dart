import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar Navigation / Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.neutral,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Page Titles
              Center(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tạo tài khoản',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bắt đầu hành trình dễ dàng của bạn ngay hôm nay.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Register Container Card
              Container(
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
                    // Full Name Field
                    AuthTextField(
                      label: 'Họ và tên',
                      hintText: 'Nhập họ và tên',
                      prefixIcon: Icons.person_outline_rounded,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),
                    
                    // Email Field
                    AuthTextField(
                      label: 'Địa chỉ Email',
                      hintText: 'Nhập địa chỉ email',
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    
                    // Password Field
                    AuthTextField(
                      label: 'Mật khẩu',
                      hintText: 'Nhập mật khẩu',
                      prefixIcon: Icons.lock_outlined,
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Confirm Password Field
                    AuthTextField(
                      label: 'Xác nhận mật khẩu',
                      hintText: 'Nhập lại mật khẩu',
                      prefixIcon: Icons.lock_outline_rounded,
                      controller: _confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    
                    // Sign Up Button
                    AuthButton(
                      text: 'Đăng ký',
                      onPressed: () {
                        // Dummy register behavior
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đăng ký tài khoản thành công!')),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // "OR REGISTER WITH" Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.border.withValues(alpha: 0.6),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'HOẶC ĐĂNG KÝ BẰNG',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.border.withValues(alpha: 0.6),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Social Button: Google (Full Width)
                    SocialButton(
                      type: SocialType.google,
                      text: 'Tiếp tục với Google',
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    
                    // Social Button: Facebook (Full Width)
                    SocialButton(
                      type: SocialType.facebook,
                      text: 'Tiếp tục với Facebook',
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    
                    // Footer Link to Login
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
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
