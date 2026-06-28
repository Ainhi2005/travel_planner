import 'package:dio/dio.dart';
import 'package:travel_planner/core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/trip_response_model.dart';
import '../models/trip_requset_model.dart'; // Chú ý: Tên file bạn đang viết sai chính tả (requset -> request)

abstract class TripRemoteDataSource {
  Future<List<TripResponseModel>> getAllTrips();
  Future<TripResponseModel> createTrip(TripRequsetModel tripModel);
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final ApiClient apiClient;

  TripRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<TripResponseModel>> getAllTrips() async {
    final respose = await apiClient.get(ApiEndpoints.trip);
    final json = respose as Map<String, dynamic>;
    final data = json['data'];
    return data.map((e) => TripResponseModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<TripResponseModel> createTrip(TripRequsetModel tripModel) async {
    final response = await apiClient.post(ApiEndpoints.trip, data: tripModel.toJson());
    final json = response as Map<String, dynamic>;
    final data = json['data'];
    return TripResponseModel.fromJson(data);
  }
}
