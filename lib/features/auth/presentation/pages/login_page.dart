import 'package:flutter/material.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'minh@gmail.com');
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              const SizedBox(height: 24),

              // App Logo Card
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF34D399), // Emerald gradient
                        Color(0xFF059669),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF059669).withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.explore_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Brand Titles
              Text(
                'Travel Planner',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Đăng nhập để bắt đầu chuyến phiêu lưu tiếp theo',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(height: 32),

              // Login Form Card
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
                    // Email Field
                    AuthTextField(
                      label: 'Địa chỉ Email',
                      hintText: 'Nhập email của bạn',
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    AuthTextField(
                      label: 'Mật khẩu',
                      hintText: 'Nhập mật khẩu',
                      prefixIcon: Icons.lock_outlined,
                      controller: _passwordController,
                      isPassword: true,
                      rightLabelWidget: GestureDetector(
                        onTap: () {
                          // Forgot password logic
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
                    const SizedBox(height: 58),

                    // Login Button
                    AuthButton(
                      text: 'Đăng nhập',
                      onPressed: () {
                        // Dummy navigate to trip list or display success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đăng nhập thành công!'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // "OR CONTINUE WITH" Divider
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
                            'HOẶC TIẾP TỤC VỚI',
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
                    const SizedBox(height: 24),

                    // Social Row
                    Row(
                      children: [
                        Expanded(
                          child: SocialButton(
                            type: SocialType.google,
                            text: 'Google',
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SocialButton(
                            type: SocialType.facebook,
                            text: 'Facebook',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Footer Link to Register
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
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRouter.register);
                          },
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
              ),
              const SizedBox(height: 32),

              // Trust and Security badges
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security_rounded,
                    size: 14,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'BẢO MẬT',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.public_rounded,
                    size: 14,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'MẠNG LƯỚI TOÀN CẦU',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
