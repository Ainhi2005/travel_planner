import 'package:flutter/material.dart';
import 'package:travel_planner/core/constant/app_spacing.dart';
import 'package:travel_planner/core/theme/app_text_styles.dart';
import 'package:travel_planner/features/trip/presentation/widgets/custom_text_field.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final tripNameController = TextEditingController();
  final guestCountController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final minBudgetController = TextEditingController();
  final maxBudgetController = TextEditingController();

  @override
  void dispose() {
    tripNameController.dispose();
    guestCountController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    minBudgetController.dispose();
    maxBudgetController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      startDateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      endDateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void _createTrip() {
    if (tripNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập tên chuyến đi'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
                        '''
              Tên: ${tripNameController.text}
              Khách: ${guestCountController.text}
              Bắt đầu: ${startDateController.text}
              Kết thúc: ${endDateController.text}
              Ngân sách: ${minBudgetController.text} - ${maxBudgetController.text}
              ''',
        ),
      ),
    );

    // TODO:
    // Gọi API tạo chuyến đi
    // ref.read(createTripProvider.notifier).createTrip(...)
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade700,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tạo chuyến đi mới',
          style: AppTextStyles.heading1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://res.cloudinary.com/dcapucva9/image/upload/v1780596248/cinema-app/sef3bxqcfiiroleflmsp.jpg',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(
              'Tên chuyến đi',
              Icons.location_on_outlined,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              controller: tripNameController,
              hintText: 'Bạn muốn đi đâu?',
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 16),

            _buildLabel(
              'Số khách',
              Icons.people_outline,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              controller: guestCountController,
              hintText: 'Nhập số khách',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            _buildLabel(
              'Ngày bắt đầu',
              Icons.calendar_today_outlined,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              controller: startDateController,
              hintText: 'dd/mm/yyyy',
              readOnly: true,
              onTap: _selectStartDate,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            _buildLabel(
              'Ngày kết thúc',
              Icons.calendar_today_outlined,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              controller: endDateController,
              hintText: 'dd/mm/yyyy',
              readOnly: true,
              onTap: _selectEndDate,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            _buildLabel(
              'Ngân sách tối thiểu',
              Icons.payments_outlined,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              controller: minBudgetController,
              hintText: '5,000,000',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            _buildLabel(
              'Ngân sách tối đa',
              Icons.payments_outlined,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              controller: maxBudgetController,
              hintText: '7,000,000',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _createTrip,
                child: const Text(
                  'Tạo chuyến đi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}