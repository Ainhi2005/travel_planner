import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class TripOverviewWidget extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final double totalBudget;
  final int peopleCount;
  const TripOverviewWidget({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.totalBudget,
    required this.peopleCount,
  });

  @override
  Widget build(BuildContext context) {
    final curruncyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'VNĐ',
    );
    final costPerson = totalBudget / peopleCount;
    final dateRange =
        '${DateFormat('dd/MM').format(startDate)}-${DateFormat('dd/MM/yyyy').format(endDate)}';
    return Column(
      children: [
        Text('Tổng quan chuyến đi ', style: AppTextStyles.caption,),
        const SizedBox(height: 16,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary,width: 1.2),
            borderRadius: BorderRadius.circular(12),       
          ),
          child: Column(
            children: [
              _buildInfoRow('Chuyến đi :', title, valueColor: AppColors.primary, isBoldValue: true),
              _buildDivider(),
              _buildInfoRow('Ngày :', dateRange, valueColor: AppColors.primary, isBoldValue: true),
              _buildDivider(),
              _buildInfoRow('Ngân sách :', curruncyFormatter.format(totalBudget), valueColor: AppColors.primary, isBoldValue: true),
              _buildDivider(),
              _buildInfoRow('Số người :', peopleCount.toString(), valueColor: AppColors.primary, isBoldValue: true),
              _buildDivider(),
              _buildInfoRow('Chi phí dự kiến :', curruncyFormatter.format(costPerson), valueColor: AppColors.primary, isBoldValue: true),
              const SizedBox(height: 10,),
               CustomButton(text: 'Sửa chuyển đi', onPressed: () {}),
            ],               
          ),
        )
      ],
    );
  }
}
Widget _buildInfoRow(
    String label, 
    String value, {
    required Color valueColor,
    bool isBoldValue = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Tiêu đề bên trái
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Màu chữ đen mờ vừa phải
              ),
            ), 
            
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Hàm tạo đường kẻ phân cách mảnh
  Widget _buildDivider() {
    return const Divider(
      color: Colors.black,// Màu đường kẻ nhạt vừa phải
      thickness: 1.2,
      height: 1,
    );
  }
