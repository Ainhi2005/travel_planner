import 'package:travel_planner/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<HomeData> getHomeData();
}