import 'package:equatable/equatable.dart';

class TripRequsetModel {
  final String id;
  final String title;
  final int guestCount;
  final DateTime startDate;
  final DateTime endDate;
  final double minBudget;
  final double maxBudget;

  const TripRequsetModel({
    required this.id,
    required this.title,
    required this.guestCount,
    required this.startDate,
    required this.endDate,
    required this.minBudget,
    required this.maxBudget,
  });
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title': title,
      'guestCount': guestCount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'minBudget': minBudget,
      'maxBudget': maxBudget,
    };
  }
}
