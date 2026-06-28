import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DatePickerField extends StatelessWidget {
  final String? label;
  final String hint;
  final String? value;
  final bool enabled;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    this.label,
    this.hint = 'Chọn ngày',
    this.value,
    this.enabled = true,
    required this.onTap,
  });

  static final DateFormat _formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.neutral.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(// là widget để bắt sự kiện click
          onTap: enabled ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.textFieldFill,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value?.isNotEmpty == true ? value! : hint,
                    style: AppTextStyles.body.copyWith(
                      color: value?.isNotEmpty == true
                          ? AppColors.neutral
                          : AppColors.textSecondary.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String format(DateTime? date) {
    if (date == null) return '';
    return _formatter.format(date);
  }

  static String formatRange(List<DateTime?> dates) {
    if (dates.length < 2 || dates[0] == null || dates[1] == null) {
      return '';
    }
    return '${_formatter.format(dates[0]!)} - ${_formatter.format(dates[1]!)}';
  }
}