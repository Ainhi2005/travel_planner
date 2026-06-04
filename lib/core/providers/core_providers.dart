import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel_planner/core/network/api_client.dart';

final apiClientProvider = Provider((ref) => ApiClient());

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());
