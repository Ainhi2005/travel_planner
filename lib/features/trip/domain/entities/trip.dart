import 'package:equatable/equatable.dart';

class Trip extends Equatable{
  final String id;
  final String title;
  final int guestCount;
  final DateTime startDate;
  final DateTime endDate;
  final double minBudget;
  final double maxBudget;
  final double totalEstimatedCost;
  final double costPerPerson;

  const Trip({
    required this.id,
    required this.title,
    required this.guestCount,
    required this.startDate,
    required this.endDate,
    required this.minBudget,
    required this.maxBudget,
    required this.totalEstimatedCost,
    required this.costPerPerson,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    guestCount,
    startDate,
    endDate,
    minBudget,
    maxBudget,
    totalEstimatedCost,
    costPerPerson,
  ];
}
