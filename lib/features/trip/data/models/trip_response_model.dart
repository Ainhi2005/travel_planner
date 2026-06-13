import 'package:equatable/equatable.dart';

class TripResponseModel{
  final String id;
  final String title;
  final int guestCount;
  final DateTime startDate;
  final DateTime endDate;
  final double totalEstimatedCost;
  final double costPerPerson;

  const TripResponseModel({
    required this.id,
    required this.title,
    required this.guestCount,
    required this.startDate,
    required this.endDate,
    required this.totalEstimatedCost,
    required this.costPerPerson,
  });
  factory TripResponseModel.fromJson(Map<String,dynamic> json){
    return TripResponseModel(
      id: json['id'],
      title: json['title'],
      guestCount: json['guestCount'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      totalEstimatedCost: json['totalEstimatedCost'],
      costPerPerson: json['costPerPerson'],
    );
  }
}
