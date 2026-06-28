import '../../domain/entities/trip.dart';
import '../../domain/entities/trip_request.dart';

class TripRequsetModel {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final int memberCount;
  final double totalBudget;
  final String? status;
  final String? imagePath;

  const TripRequsetModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.memberCount,
    required this.totalBudget,
    this.status,
    this.imagePath,
  });
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "start_date":
          "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      "end_date":
          "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      "member_count": memberCount,
      "total_budget": totalBudget,
      "status": status ?? 'upcoming',
    };
  }

  factory TripRequsetModel.fromEntity(TripRequest entity) {
    return TripRequsetModel(
      title: entity.title,
      startDate: entity.startDate,
      endDate: entity.endDate,
      memberCount: entity.memberCount,
      totalBudget: entity.totalBudget,
      status: entity.status,
      imagePath: entity.imagePath,
    );
  }
}
