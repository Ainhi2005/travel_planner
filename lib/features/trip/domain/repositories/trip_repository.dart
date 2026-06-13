import '../entities/trip.dart';

abstract class TripRepository {
  Future<void> createTrip();
  Future<List<Trip>> getTrips();
}
