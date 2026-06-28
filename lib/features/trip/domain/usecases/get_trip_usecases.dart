import 'package:travel_planner/features/trip/domain/entities/trip.dart';
import 'package:travel_planner/features/trip/domain/repositories/trip_repository.dart';

class GetTripUsecases {
  final TripRepository repository;

  GetTripUsecases(this.repository);

  Future<List<TripEntity>> execute() {
    return repository.getAllTrips();
  }
}