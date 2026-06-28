import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/widgets/custom_button.dart';
import 'package:travel_planner/core/widgets/custom_text_field.dart';
import 'package:travel_planner/features/trip/domain/entities/trip_request.dart';
import 'package:travel_planner/features/trip/presentation/providers/trip_provider.dart';
import 'package:travel_planner/features/trip/presentation/widgets/trip_overview_widget.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/open_datePicker_widget.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../../core/theme/app_calendar_theme.dart';
import '../../../../core/widgets/snackbar_widget.dart';
import '../widgets/people_counter_widget.dart';

class TripPage extends ConsumerStatefulWidget {
  const TripPage({super.key});
  @override
  ConsumerState<TripPage> createState() => _TripPageState();
}

class _TripPageState extends ConsumerState<TripPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  List<DateTime?> _selectedDates = [];
  int _memberCount = 1;
  bool _isLoading = false;
  TripRequest? _createdTrip;
  @override
  void dispose() {
    _titleController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _onSelectDatePressed() async {
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      config: AppCalendarTheme.rangeConfig(),
      dialogSize: const Size(325, 400),
      value: _selectedDates,
      borderRadius: BorderRadius.circular(15),
    );

    if (results != null && results.isNotEmpty) {
      setState(() {
        _selectedDates = results;
      });

      if (results.length > 1 && results[1] != null) {
        print('Từ ngày: ${results[0]} - Đến ngày: ${results[1]}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo chuyến đi', style: AppTextStyles.heading1),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomTextField(
              controller: _titleController,
              hintText: 'Nhập tên chuyến đi',
              label: 'Tên chuyến đi',
            ),
            const SizedBox(height: 16),

            // 2. Chọn Ngày đi và Ngày về (Nằm ngang nhau)
            Row(
              children: [
                Expanded(
                  child: DatePickerField(
                    label: 'Ngày đi',
                    hint: 'dd/MM/yyyy',
                    value: _selectedDates.isNotEmpty
                        ? DatePickerField.format(_selectedDates[0])
                        : null,
                    onTap: _onSelectDatePressed,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DatePickerField(
                    label: 'Ngày về',
                    hint: 'dd/MM/yyyy',
                    // Lấy ngày thứ hai trong mảng (nếu có)
                    value: _selectedDates.length > 1
                        ? DatePickerField.format(_selectedDates[1])
                        : null,
                    onTap: _onSelectDatePressed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            PeopleCounterWidget(
              lable: 'Số người',
              initialValue: 1,
              minValue: 1,
              onChanged: (value) => _memberCount = value,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _budgetController,
              hintText: 'Nhập ngân sách dự kiến',
              label: 'Ngân sách dự kiến',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            if (_createdTrip == null) CustomButton(text: 'Tạo chuyến đi mới', onPressed: _sublitTrip),
            const SizedBox(height: 16),
            if (_createdTrip != null)...[
              TripOverviewWidget(
                title: _createdTrip!.title,
                startDate: _createdTrip!.startDate,
                endDate: _createdTrip!.endDate,
                totalBudget: _createdTrip!.totalBudget,
                peopleCount: _createdTrip!.memberCount,
              )
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _sublitTrip() async {
    if (_titleController.text.trim().isEmpty ||
        _budgetController.text.trim().isEmpty ||
        _selectedDates.length < 2) {
      SnackbarWidget.error(context, 'Vui lòng nhập đủ thông tin ');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final tripRequest = TripRequest(
        title: _titleController.text.trim(),
        startDate: _selectedDates[0]!,
        endDate: _selectedDates[1]!,
        totalBudget: double.tryParse(_budgetController.text.trim()) ?? 0,
        memberCount: _memberCount,
      );
      final uc = ref.read(createTripUseCaseProvider);
      await uc.execute(tripRequest);
      if (mounted) {
        SnackbarWidget.success(context, 'Tạo chuyến đi thành công');
        setState(() {
          _createdTrip = tripRequest;
        });
      }
    } catch (e) {
      if (mounted) {
        SnackbarWidget.error(context, 'Tạo chuyến đi thất bại');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
