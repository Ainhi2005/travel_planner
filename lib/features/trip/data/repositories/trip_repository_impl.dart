import '../../domain/entities/trip.dart';
import '../../domain/entities/trip_request.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_data_source.dart';
import '../models/trip_requset_model.dart';
import '../models/trip_response_model.dart'; 

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource remoteDataSource;

  TripRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TripEntity>> getAllTrips() async {
    final remoteTrips = await remoteDataSource.getAllTrips();
    return remoteTrips.map((model) => model.toEntity()).toList();
  }

  @override
  Future<TripEntity> createTrip(TripRequest request) async {
    final requestModel = TripRequsetModel.fromEntity(request);
    final responseModel = await remoteDataSource.createTrip(requestModel);
    return responseModel.toEntity();
  }
}
      