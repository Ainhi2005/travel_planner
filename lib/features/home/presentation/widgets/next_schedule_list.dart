import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/home_entity.dart';

class NextScheduleList extends StatelessWidget {
  final List<NextItem> nextItems;
  const NextScheduleList({super.key, required this.nextItems});

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi dữ liệu từ entity sang Map để dễ xài
    final List<Map<String, dynamic>> schedules = nextItems.map((e) => {
      'image': e.imgUrl, // Lưu ý: ở đây phải dùng e.imgUrl thay vì e.id nhé
      'title': e.title,
      'time': e.startTime, // Có thể bạn sẽ cần viết hàm format lại giờ như cái CurrentItemCard
      'distance': e.distance,
    }).toList();

    return ListView.builder(
      shrinkWrap: true, // Co dãn vừa khít nội dung
      physics: const NeverScrollableScrollPhysics(), // Ngăn không cho lướt trong listview
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final item = schedules[index];
        
        // Trả về trực tiếp giao diện cái thẻ luôn, không bọc qua Timeline nữa
        return Padding(
          padding: const EdgeInsets.only(bottom: 16), // Chỉ giữ lại khoảng cách bên dưới
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 235, 235),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item['image'],
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['time'],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['distance'],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: AppColors.neutral),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
