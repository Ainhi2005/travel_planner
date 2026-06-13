import 'package:travel_planner/core/network/api_endpoints.dart';
import 'package:travel_planner/features/home/data/models/home_model.dart';
import 'package:travel_planner/core/network/api_client.dart';

class HomeRemoteDatasources {
  final ApiClient apiClient;
  HomeRemoteDatasources({required this.apiClient});
  
  Future<HomeModel> getHomeData() async {
    // Trả lại kết nối tới mockHomes
    final responseData = await apiClient.get('${ApiEndpoints.mockHomes}/${ApiEndpoints.home}');
    
    final data = responseData['data'] ?? responseData;
    return HomeModel.fromJson(data);
  }
}

