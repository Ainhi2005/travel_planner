import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Bắt buộc phải có để xài Provider
import 'package:timeline_tile/timeline_tile.dart';
import 'package:travel_planner/core/constant/app_spacing.dart';
import 'package:travel_planner/core/theme/app_colors.dart';
import 'package:travel_planner/features/home/presentation/widgets/current_item_card.dart';
import 'package:travel_planner/features/home/presentation/widgets/home_header.dart';
import 'package:travel_planner/features/home/presentation/widgets/warning_banner.dart';
// Import cái Provider lúc nãy bạn vừa tạo
import '../../../trip/presentation/pages/trip_page.dart';
import '../providers/home_provider.dart';
import '../widgets/active_trip.dart';
import '../widgets/next_schedule_header.dart';
import '../widgets/next_schedule_list.dart';
import '../widgets/utilities.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TripPage()));
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: homeState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              Center(child: Text('Lỗi tải dữ liệu: $error')),

          // 5. Nếu API gọi thành công, nó sẽ đẻ ra biến "homeData", lúc này bạn tha hồ xài!
          data: (homeData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: 24),
                    if (homeData.currentItem != null) ...[
                      CurrentItemCard(item: homeData.currentItem!),
                      const SizedBox(height: 32),
                    ],
                    Utilities(),
                    const SizedBox(height: 24),
                    WarningBanner(groupAlert: homeData.groupAlert!),
                    const SizedBox(height: 24),
                    ActiveTripWidget(activeTrip: homeData.activeTrip!),
                    const SizedBox(height: 32),
                    NextScheduleHeader(),
                    const SizedBox(height: 16),
                    NextScheduleList(nextItems: homeData.nextItems),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}