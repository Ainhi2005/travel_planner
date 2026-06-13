import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ActivityType { eating, playing, moving, staying }

class ScheduleDetail extends Equatable {
  final String id;
  final String tripId;
  final String location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final ActivityType type;
  final double estimatedCost;
  final DateTime date;
  final String? note;
  ScheduleDetail({
    required this.id,
    required this.tripId,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.estimatedCost,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [
    id,
    tripId,
    location,
    startTime,
    endTime,
    type,
    estimatedCost,
    date,
    note,
  ];
}
