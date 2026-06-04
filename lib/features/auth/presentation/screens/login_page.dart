import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_planner/core/routes/app_path.dart';
import 'package:travel_planner/core/widgets/custom_text_field.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/auth_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('remember_phone') ?? '';
    final password = prefs.getString('remember_password') ?? '';
    final isRememberMe = prefs.getBool('remember_me') ?? false;

    if (isRememberMe) {
      setState(() {
        _phoneController.text = phone;
        _passwordController.text = password;
        _isRememberMe = true;
      });
    }
  }

  Future<void> _saveOrClearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isRememberMe) {
      await prefs.setString('remember_phone', _phoneController.text.trim());
      await prefs.setString('remember_password', _passwordController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('remember_phone');
      await prefs.remove('remember_password');
      await prefs.setBool('remember_me', false);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    ref.listen<AuthState>(authProvider, (previous, next) async {
      if (next.user != null && previous?.user == null) {
        await _saveOrClearCredentials();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng nhập thành công!'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go(AppPath.home);
        }
      } else if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor:AppColors.error,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
    });
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 54),

              // Brand Titles
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travel Planner',

                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.secondary,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Đăng nhập để bắt đầu chuyến phiêu lưu tiếp theo',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 62),

              // Login Form Card
              Container(
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
                    // phone Field
                    CustomTextField(
                      label: 'Sô điện thoại',
                      hintText: 'Nhập số điện thoại',
                      prefixIcon: Icons.call,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    CustomTextField(
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
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // nhớ mật khâir
                    Row(
                      children: [
                        Checkbox(
                          value: _isRememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _isRememberMe = value ?? false;
                            });
                          },
                        ),
                        Text("Nhớ mật khẩu"),
                      ],
                    ),
                    const SizedBox(height: 38),
                    // Login Button
                    AuthButton(
                      text: authState.isLoading ? 'Đang đn...' : 'đăng nhập',
                      onPressed: authState.isLoading
                          ? null
                          : () {
                              final phone = _phoneController.text.trim();
                              final password = _passwordController.text;
                              //kiểm tra đầu vào
                              if (phone.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("vui lòng nhập mật khẩu"),
                                    backgroundColor: AppColors.background,
                                  ),
                                );
                                return;
                              }
                              // gọi hàm login trong AuthNotifier
                              ref
                                  .read(authProvider.notifier)
                                  .login(phone, password);
                            },
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
                          onTap: () => context.push(AppPath.register),
                          child: Text(
                            'Đăng ký',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.secondary,
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
            ],
          ),
        ),
      ),
    );
  }
}
