import 'package:hive/hive.dart';

part 'reading_plan.g.dart'; // This should be the first line in the file

@HiveType(typeId: 0)
class ReadingPlan extends HiveObject {
  @HiveField(0)
  late DateTime plannedStartDate;

  @HiveField(1)
  late DateTime plannedEndDate;

  @HiveField(2)
  late bool includeOldTestament;

  @HiveField(3)
  late bool includeApocrypha;

  @HiveField(4)
  late bool includeNewTestament;

  @HiveField(5)
  late List<DailyReading> dailyReadings;
}

@HiveType(typeId: 1)
class DailyReading {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late String passage;
}
