import '../entities/trip.dart';
import '../entities/trip_request.dart';

abstract class TripRepository {
  Future<TripEntity> createTrip(TripRequest request);
  Future<List<TripEntity>> getAllTrips();
}
