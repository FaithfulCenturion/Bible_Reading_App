import 'package:hive_flutter/hive_flutter.dart';
import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:path_provider/path_provider.dart'; // Adjust the path if needed

class HiveService {
  static final HiveService _instance = HiveService._internal();

  // Private constructor for Singleton pattern
  HiveService._internal();

  // Factory constructor to get the instance
  factory HiveService() {
    return _instance;
  }

  late Box<ReadingPlan> readingPlanBox;

  // Initialize Hive and open the box
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    // Initialize Hive
    Hive.init(directory.path);

    Hive.registerAdapter(ReadingPlanAdapter());
    Hive.registerAdapter(DailyReadingAdapter());

    readingPlanBox = await openReadingPlanBox();
  }

  Future<Box<ReadingPlan>> openReadingPlanBox() async {
    return await Hive.openBox<ReadingPlan>('readingPlans');
  }

  // Close the box when the app is disposed or on app exit
  Future<void> close() async {
    await readingPlanBox.close();
  }
}
