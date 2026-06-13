import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart' show AppColors;

class Utilities extends StatelessWidget {
  const Utilities({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.calendar_today_outlined, 'label': 'Lịch trình'},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'Ngân sách'},
      {'icon': Icons.fact_check_outlined, 'label': 'Checklist'},
      {'icon': Icons.collections_outlined, 'label': 'Kỷ niệm'},
    ];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tiện ích',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              return Container(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                        decoration: BoxDecoration(color: AppColors.background),
                        child: Icon(
                          item['icon'] as IconData,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}