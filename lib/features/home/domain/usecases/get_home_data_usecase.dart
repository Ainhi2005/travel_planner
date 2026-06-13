import 'package:travel_planner/features/home/domain/entities/home_entity.dart';
import 'package:travel_planner/features/home/domain/repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository homeRepository;
  GetHomeDataUsecase(this.homeRepository);
  Future<HomeData> call(){
    return homeRepository.getHomeData();
  }
}
