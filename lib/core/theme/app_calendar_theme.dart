import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppCalendarTheme {
  AppCalendarTheme._();

  /// Cấu hình chọn khoảng ngày (Check-in / Check-out)
  static CalendarDatePicker2WithActionButtonsConfig rangeConfig() {
    return CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,

      // Ngày bắt đầu tuần
      firstDayOfWeek: 1,

      // Hiển thị Action Buttons
      okButton: const Text(
        'Xác nhận',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      cancelButton: const Text(
        'Hủy',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Màu ngày được chọn
      selectedDayHighlightColor: AppColors.primary,

      // Màu khoảng giữa 2 ngày
      selectedRangeHighlightColor: AppColors.primary.withValues(alpha: 0.15),

      // Màu ngày hiện tại
      todayTextStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),

      // Bo góc ngày được chọn
      dayBorderRadius: BorderRadius.circular(12),

      // Animation
      animateToDisplayedMonthDate: true,

      // Không cho chọn ngày quá khứ (nếu dùng đặt tour)
      // firstDate: DateTime.now(),

      // Ngày cuối
      lastDate: DateTime(2100),
    );
  }

  /// Cấu hình chọn một ngày (Ngày sinh, ...)
  static CalendarDatePicker2WithActionButtonsConfig singleConfig() {
    return CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,

      firstDayOfWeek: 1,

      okButton: const Text(
        'Xác nhận',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      cancelButton: const Text(
        'Hủy',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),

      selectedDayHighlightColor: AppColors.primary,

      todayTextStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),

      dayBorderRadius: BorderRadius.circular(12),

      animateToDisplayedMonthDate: true,

      lastDate: DateTime(2100),
    );
  }
}