import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/trip_remote_data_source.dart';
import '../../data/repositories/trip_repository_impl.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../../domain/usecases/create_trip.dart';
import '../../domain/usecases/get_trip_usecases.dart';

// 1. Data Source Provider
final tripRemoteDataSourceProvider = Provider<TripRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TripRemoteDataSourceImpl(apiClient: apiClient);
});

// 2. Repository Provider
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final remoteDataSource = ref.watch(tripRemoteDataSourceProvider);
  return TripRepositoryImpl(remoteDataSource: remoteDataSource);
});

// 3. Use Cases Providers
final createTripUseCaseProvider = Provider<CreateTripUseCase>((ref) {
  final repository = ref.watch(tripRepositoryProvider);
  return CreateTripUseCase(repository);
});

final getTripUseCaseProvider = Provider<GetTripUsecases>((ref) {
  final repository = ref.watch(tripRepositoryProvider);
  return GetTripUsecases(repository);
});

// 4. State Provider: Quản lý danh sách chuyến đi
final tripListProvider = FutureProvider.autoDispose<List<TripEntity>>((ref) async {
  final getTripUseCase = ref.watch(getTripUseCaseProvider);
  return await getTripUseCase.execute();
});
