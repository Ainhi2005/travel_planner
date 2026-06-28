import '../../domain/entities/trip.dart';

class TripResponseModel{
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

  const TripResponseModel({
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

  factory TripResponseModel.fromJson(Map<String, dynamic> json) {
    return TripResponseModel(
      id: json['id'],
      title: json['title'],
      //coverImage: json['coverImage'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      leadId: json['lead_id'],
      leadName: json['lead_id'],
      leadAvatar: json['lead_id'],
      totalBudget: (json['total_budget'] as num).toDouble(),
      memberCount: json['member_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  TripEntity toEntity() {
    return TripEntity(
      id: id,
      title: title,
      //coverImage: coverImage,
      startDate: startDate,
      endDate: endDate,
      status: status,
      leadId: leadId,
      leadName: leadName,
      leadAvatar: leadAvatar,
      totalBudget: totalBudget,
      memberCount: memberCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
