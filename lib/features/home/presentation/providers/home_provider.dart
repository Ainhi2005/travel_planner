import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/providers/core_providers.dart';
import 'package:travel_planner/features/home/data/datasources/home_remote_datasources.dart';
import 'package:travel_planner/features/home/data/repositories/home_repository_impl.dart';
import 'package:travel_planner/features/home/domain/entities/home_entity.dart';
import 'package:travel_planner/features/home/domain/repositories/home_repository.dart';
import 'package:travel_planner/features/home/domain/usecases/get_home_data_usecase.dart';

final homeRemoteDatasourcesProvider = Provider<HomeRemoteDatasources>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return HomeRemoteDatasources(apiClient: apiClient);
});
final HomeRepositoryProvider = Provider<HomeRepository>((ref) {
  final datasource = ref.read(homeRemoteDatasourcesProvider);
  return HomeRepositoryImpl(homeRemoteDatasources: datasource);
});// 3. UseCase (Cung cấp UseCase, lấy Repository nhét vào)
final getHomeDataUseCaseProvider = Provider<GetHomeDataUsecase>((ref) {
  final repoitory = ref.read(HomeRepositoryProvider);
  return GetHomeDataUsecase(repoitory);
});
final homeProvider=FutureProvider<HomeData>((ref)async{
  final getHomeData=ref.read(getHomeDataUseCaseProvider);
  return await getHomeData.call();
});