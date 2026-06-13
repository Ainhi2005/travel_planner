import 'package:travel_planner/features/home/data/datasources/home_remote_datasources.dart';
import 'package:travel_planner/features/home/domain/entities/home_entity.dart';
import 'package:travel_planner/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasources homeRemoteDatasources;
  HomeRepositoryImpl({required this.homeRemoteDatasources});
  @override
  Future<HomeData> getHomeData() async {
    try {
      final result = await homeRemoteDatasources.getHomeData();
      return result;
    } catch (e) {
      rethrow;// // Bắt lỗi và quăng ngược lên trên cho Provider xử lý
    }
  }
}
