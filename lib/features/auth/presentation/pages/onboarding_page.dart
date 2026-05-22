import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/routes/app_path.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/auth_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              // Header Brand Row
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, //spacebetween là cách để căn chỉnh khoảng cách giữa các widget
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.flight_takeoff_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Travel Planner',
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => context.pushReplacement(AppPath.login),
                    child: Text(
                      'Bỏ qua',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1),

              // Onboarding Image Card Container
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main Photo Card
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/onboarding_plan.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.blue.shade100,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 64,
                                color: Colors.blue.shade400,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Floating Badge
                    Positioned(
                      bottom: -15,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.people_alt_rounded,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Lập kế hoạch chung',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.neutral,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Text Content
              Text(
                'Lập kế hoạch chuyến\nđi nhóm dễ dàng',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Đồng bộ hành trình theo thời gian thực và để mỗi người cùng đóng góp cho chuyến phiêu lưu. Không còn những nhóm chat lộn xộn.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.5,
                  height: 1.45,
                ),
              ),

              const Spacer(flex: 1),

              // Dot Indicator Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1),

              // Action Button
              AuthButton(
                text: 'Tiếp theo',
                onPressed: () => context.pushReplacement(AppPath.login),
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
