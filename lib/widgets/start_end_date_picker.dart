import 'package:flutter/material.dart';

class StartEndDatePicker extends StatefulWidget {
  final Function(String) onStartDateChanged;
  final Function(String) onEndDateChanged;

  const StartEndDatePicker({
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    super.key,
  });

  @override
  _StartEndDatePickerState createState() => _StartEndDatePickerState();
}

class _StartEndDatePickerState extends State<StartEndDatePicker> {
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  @override
  void initState() {
    super.initState();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: startDateController,
          decoration: const InputDecoration(labelText: 'Planned Start Date'),
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: today,
              firstDate: firstDate,
              lastDate: lastDate,
            );
            if (date != null) {
              final dateString = date.toIso8601String().split('T').first;
              startDateController.text = dateString;
              widget.onStartDateChanged(dateString);
            }
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: endDateController,
          decoration: const InputDecoration(labelText: 'Planned End Date'),
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
                context: context,
                initialDate: DateTime(today.year + 1, today.month, today.day),
                firstDate: firstDate,
                lastDate: lastDate);
            if (date != null) {
              final dateString = date.toIso8601String().split('T').first;
              endDateController.text = dateString;
              widget.onEndDateChanged(dateString);
            }
          },
        )
      ],
    );
  }
}
