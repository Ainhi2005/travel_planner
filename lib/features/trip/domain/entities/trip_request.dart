// lib/features/trip/domain/entities/trip_request.dart
import 'package:equatable/equatable.dart';

class TripRequest  {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final int memberCount;
  final double totalBudget;
  final String? status;
  final String? imagePath;

  const TripRequest({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.memberCount,
    required this.totalBudget,
    this.status,
    this.imagePath,
  });
}