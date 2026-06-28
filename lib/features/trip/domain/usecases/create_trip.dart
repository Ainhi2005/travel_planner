import 'package:travel_planner/features/trip/domain/entities/trip_request.dart';
import 'package:travel_planner/features/trip/domain/repositories/trip_repository.dart';

import '../entities/trip.dart';

class CreateTripUseCase {
  final TripRepository repository;

  CreateTripUseCase(this.repository);

  Future<TripEntity> execute(TripRequest request) {
    return repository.createTrip(request);
  }
}