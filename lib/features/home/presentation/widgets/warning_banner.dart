import 'package:flutter/material.dart';
import '../../domain/entities/home_entity.dart';
import '../../../../core/theme/app_colors.dart';

class WarningBanner extends StatelessWidget {
  final GroupAlert groupAlert;
  const WarningBanner({super.key, required this.groupAlert});

  @override
  Widget build(BuildContext context) {
    // Dùng Align thay cho Spacer để ép cái khung luôn bám sát lề phải
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // Giới hạn chiều rộng tối đa của khung (ví dụ chiếm tối đa 85% màn hình) để nó không bè ra quá to
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85, 
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 219, 178),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Co dãn vừa khít nội dung
          crossAxisAlignment: CrossAxisAlignment.start, // Để Icon luôn nằm ở dòng đầu tiên nếu chữ dài 2 dòng
          children: [
            Icon(Icons.warning, color: AppColors.warning, size: 20), // Thu nhỏ icon một chút cho cân đối
            const SizedBox(width: 12),
            
            // Bọc Flexible để chữ khi đụng viền khung sẽ tự động rớt xuống dòng
            Flexible(
              child: Text(
                groupAlert.message,
                style: TextStyle(
                  color: AppColors.warning,
                  fontWeight: FontWeight.bold,
                  fontSize: 13, // Đã chỉnh nhỏ hơn xíu (Từ 16 xuống 13)
                  height: 1.4, // Tạo khoảng cách giữa 2 dòng chữ cho dễ đọc
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
