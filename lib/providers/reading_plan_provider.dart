import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:bible_reader_app/providers/bible_provider.dart';
import 'package:bible_reader_app/services/hive_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the Riverpod state notifier
final readingPlanProvider =
    StateNotifierProvider<ReadingPlanNotifier, ReadingPlan?>((ref) {
  return ReadingPlanNotifier(ref);
});

class ReadingPlanNotifier extends StateNotifier<ReadingPlan?> {
  final Ref ref;

  ReadingPlanNotifier(this.ref) : super(null);

  Future<void> createReadingPlan(
      DateTime start, DateTime end, bool ot, bool apoc, bool nt) async {
    // Generate the daily readings
    final dailyReadings = await _generateDailyReadings(start, end, ot, apoc, nt);

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

  Future<List<DailyReading>> _generateDailyReadings(
    DateTime start, DateTime end, bool ot, bool apoc, bool nt) async {
  final totalDays = end.difference(start).inDays + 1;
  
  final allPassages = <String>[];
  final bibleProviderInstance = ref.read(bibleProvider);


  if (ot) {
    final oldTestamentVerses = await bibleProviderInstance.loadVerses(bibleProviderInstance.oldTestamentChapters);
    allPassages.addAll(oldTestamentVerses);
  }
  if (apoc) {
    final apocryphaVerses = await bibleProviderInstance.loadVerses(bibleProviderInstance.apocryphaChapters);
    allPassages.addAll(apocryphaVerses);
  }
  if (nt) {
    final newTestamentVerses = await bibleProviderInstance.loadVerses(bibleProviderInstance.newTestamentChapters);
    allPassages.addAll(newTestamentVerses);
  }

  final dailyReadings = <DailyReading>[];
  final versesPerDay = (allPassages.length / totalDays).ceil();

  for (var i = 0; i < totalDays; i++) {
    final dayPassages =
        allPassages.skip(i * versesPerDay).take(versesPerDay).join(', ');
    dailyReadings.add(DailyReading()
      ..date = start.add(Duration(days: i))
      ..passage = dayPassages);
  }
  print(dailyReadings);
  return dailyReadings;
}

  
}
