import 'package:travel_planner/core/network/api_endpoints.dart';
import 'package:travel_planner/features/auth/data/models/auth_request_model.dart';
import 'package:travel_planner/features/auth/data/models/auth_response_model.dart';
import 'package:travel_planner/core/network/api_client.dart';

class AuthRemoteDatasource {
  final ApiClient apiClient;
  AuthRemoteDatasource(this.apiClient);
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final responseData = await apiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(responseData);
  }

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    final responseData = await apiClient.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(responseData);
  }
}
