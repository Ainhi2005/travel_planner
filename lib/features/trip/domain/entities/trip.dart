// lib/features/trip/domain/entities/trip.dart
import 'package:equatable/equatable.dart';

class TripEntity {
  final String id;
  final String title;
  //final String coverImage;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String leadId;
  final String? leadName;
  final String? leadAvatar;
  final double totalBudget;
  final int memberCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TripEntity({
    required this.id,
    required this.title,
    //required this.coverImage,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.leadId,
    this.leadName,
    this.leadAvatar,
    required this.totalBudget,
    required this.memberCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
