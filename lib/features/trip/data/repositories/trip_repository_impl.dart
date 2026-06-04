import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_data_source.dart';
import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource _remoteDataSource;

  TripRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Trip>> getTrips() async {
    try {
      final tripModels = await _remoteDataSource.getTrips();
      return tripModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Lấy danh sách chuyến đi thất bại: $e');
    }
  }
}
