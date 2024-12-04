import 'package:bible_reader_app/providers/bible_section_providers.dart';
import 'package:bible_reader_app/providers/button_enabled_provider.dart';
import 'package:bible_reader_app/providers/reading_plan_provider.dart';
import 'package:bible_reader_app/widgets/start_end_date_picker.dart';
import 'package:bible_reader_app/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateReadingPlanScreen extends ConsumerWidget {
  const CreateReadingPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the button state
    final isButtonEnabled = ref.watch(isButtonEnabledProvider);

    String? startDate;
    String? endDate;

    // Watch the toggle states
    final includeOT = ref.watch(includeOTProvider);
    final includeApoc = ref.watch(includeApocProvider);
    final includeNT = ref.watch(includeNTProvider);

    // Function to validate the date fields
    void validateDates(String start, String end) {
      final parsedStart = DateTime.tryParse(start);
      final parsedEnd = DateTime.tryParse(end);

      // Update the start and end date providers
      ref.read(startDateProvider.notifier).state = parsedStart;
      ref.read(endDateProvider.notifier).state = parsedEnd;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Create Reading Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StartEndDatePicker(onStartDateChanged: (date) {
              startDate = date;
              validateDates(startDate ?? '', endDate ?? '');
            }, onEndDateChanged: (date) {
              endDate = date;
              validateDates(startDate ?? '', endDate ?? '');
            }),
            SizedBox(height: 16),
            ToggleSwitch(
              title: 'Include Old Testament',
              value: ref.watch(includeOldTestamentProvider),
              onChanged: (value) =>
                  ref.read(includeOldTestamentProvider.notifier).state = value,
            ),
            ToggleSwitch(
              title: 'Include Apocrypha',
              value: ref.watch(includeApocryphaProvider),
              onChanged: (value) =>
                  ref.read(includeApocryphaProvider.notifier).state = value,
            ),
            ToggleSwitch(
              title: 'Include New Testament',
              value: ref.watch(includeNewTestamentProvider),
              onChanged: (value) =>
                  ref.read(includeNewTestamentProvider.notifier).state = value,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      final startDate = ref.read(startDateProvider);
                      final endDate = ref.read(endDateProvider);

                      ref.read(readingPlanProvider.notifier).createReadingPlan(
                            startDate!,
                            endDate!,
                            includeOT,
                            includeApoc,
                            includeNT,
                          );
                      Navigator.pop(context);
                    }
                  : null, // Disable button if validation fails
              child: const Text('Create Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
