import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PeopleCounterWidget extends StatefulWidget {
  final String lable;
  final String? unit;
  final int initialValue;
  final int minValue;
  final int? maxValue;
  final Function(int)? onChanged;
  const PeopleCounterWidget({
    super.key,
    required this.lable,
    this.unit,
    required this.initialValue,
    required this.minValue,
    this.maxValue,
    this.onChanged,
  });

  @override
  State<PeopleCounterWidget> createState() => _PeopleCounterWidgetState();
}

class _PeopleCounterWidgetState extends State<PeopleCounterWidget> {
  late int value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void decreaseValue() {
    setState(() {
      if (value > widget.minValue) {
        value--;
        widget.onChanged?.call(value);
      }
    });
  }

  void increaseValue() {
    setState(() {
      value++;
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.textFieldFill,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(widget.lable,style: AppTextStyles.body)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:decreaseValue,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white
                    ),
                    child: Icon(Icons.remove,size: 20, color: AppColors.neutral),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$value',
                  style: AppTextStyles.body,
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap:increaseValue,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(Icons.add,size: 20, color: AppColors.neutral),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
