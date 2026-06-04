import '../../../../core/network/api_client.dart';
import '../models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<List<TripModel>> getTrips();
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final ApiClient _apiClient;

  TripRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<TripModel>> getTrips() async {
    final response = await _apiClient.dio.get('/trips');
    final data = response.data as List;
    return data
        .map((json) => TripModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
