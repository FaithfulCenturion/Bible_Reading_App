import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:bible_reader_app/services/hive_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the Riverpod state notifier
final readingPlanProvider =
    StateNotifierProvider<ReadingPlanNotifier, ReadingPlan?>((ref) {
  return ReadingPlanNotifier();
});

class ReadingPlanNotifier extends StateNotifier<ReadingPlan?> {
  ReadingPlanNotifier() : super(null);

  Future<void> createReadingPlan(
      DateTime start, DateTime end, bool ot, bool apoc, bool nt) async {
    // Generate the daily readings
    final dailyReadings = _generateDailyReadings(start, end, ot, apoc, nt);

    // Create a new ReadingPlan object
    ReadingPlan newPlan = ReadingPlan()
      ..plannedStartDate = start
      ..plannedEndDate = end
      ..includeOldTestament = ot
      ..includeApocrypha = apoc
      ..includeNewTestament = nt
      ..dailyReadings = dailyReadings;

    // Save or update the reading plan in Hive
    await _addOrUpdateReadingPlan(newPlan);

    state = newPlan;
  }

  // Function to add or update the reading plan in Hive
  Future<void> _addOrUpdateReadingPlan(ReadingPlan plan) async {
    try {
      // Access the Hive box using HiveService
      var box = HiveService().readingPlanBox;

      // Add or update the reading plan, using startDate as the key (or a unique identifier)
      await box.put(plan.plannedStartDate.toIso8601String(), plan);
    } catch (e) {
      print('Error adding/updating reading plan: $e');
    }
  }

  List<DailyReading> _generateDailyReadings(
      DateTime start, DateTime end, bool ot, bool apoc, bool nt) {
    // Example implementation: Distribute chapters evenly between start and end dates
    final totalDays = end.difference(start).inDays + 1;
    final passages = <String>[];

    if (ot) passages.addAll(_oldTestamentPassages());
    if (apoc) passages.addAll(_apocryphaPassages());
    if (nt) passages.addAll(_newTestamentPassages());

    final dailyReadings = <DailyReading>[];
    final chaptersPerDay = (passages.length / totalDays).ceil();

    for (var i = 0; i < totalDays; i++) {
      final dayPassages =
          passages.skip(i * chaptersPerDay).take(chaptersPerDay).join(', ');
      dailyReadings.add(DailyReading()
        ..date = start.add(Duration(days: i))
        ..passage = dayPassages);
    }

    return dailyReadings;
  }

  List<String> _oldTestamentPassages() =>
      ["Genesis 1-2", "Exodus 1-3"]; // Add real data
  List<String> _apocryphaPassages() =>
      ["1 Maccabees 1", "Wisdom 1"]; // Add real data
  List<String> _newTestamentPassages() =>
      ["Matthew 1", "John 1"]; // Add real data
}
