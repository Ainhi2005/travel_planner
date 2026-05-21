import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

enum SocialType { google, facebook }

class SocialButton extends StatelessWidget {
  final SocialType type;
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;

  const SocialButton({
    super.key,
    required this.type,
    required this.text,
    this.onPressed,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGoogle = type == SocialType.google;

    // Compact styles (Login Page)
    // Full width styles (Register Page)
    final Color defaultBgColor = isGoogle 
        ? Colors.white 
        : (isFullWidth ? const Color(0xFFE8F0FE) : Colors.white);
    
    final Color defaultTextColor = isGoogle 
        ? AppColors.neutral.withValues(alpha: 0.8) 
        : (isFullWidth ? const Color(0xFF1877F2) : AppColors.neutral.withValues(alpha: 0.8));

    final Widget logo = _buildLogo(isGoogle, isFullWidth);

    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: defaultBgColor,
          foregroundColor: defaultTextColor,
          side: isFullWidth 
              ? BorderSide.none 
              : BorderSide(color: AppColors.border.withValues(alpha: 0.8), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
        ),
        child: isFullWidth
            ? Row(
                children: [
                  logo,
                  Expanded(
                    child: Center(
                      child: Text(
                        text,
                        style: AppTextStyles.button.copyWith(
                          color: defaultTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 28), // to offset the logo size and center the text
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  logo,
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: defaultTextColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLogo(bool isGoogle, bool isFullWidth) {
    if (isGoogle) {
      // Draw Google 'G' icon using a clean widget structure
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'G',
          style: TextStyle(
            color: Color(0xFFEA4335), // Google Red
            fontSize: 18,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
          ),
        ),
      );
    } else {
      // Draw Facebook 'f' icon
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFF1877F2), // Facebook Blue
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'f',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      );
    }
  }
}
