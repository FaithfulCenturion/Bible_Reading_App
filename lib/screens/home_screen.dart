import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:bible_reader_app/screens/reading_plan/view_reading_plan_screen.dart';
import 'package:bible_reader_app/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:bible_reader_app/screens/bible/bible_books_screen.dart';
import 'package:bible_reader_app/screens/reading_plan/create_reading_plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ReadingPlan?> _currentReadingPlan;

  @override
  void initState() {
    super.initState();
    _currentReadingPlan = _getCurrentReadingPlan();
  }

  Future<ReadingPlan?> _getCurrentReadingPlan() async {
    try {
      var box = HiveService().readingPlanBox;
      if (box.isNotEmpty) {
        final plans = box.values.cast<ReadingPlan>().toList();
        // Assuming only one plan exists, you could extend this for multiple plans
        final readingPlan = plans.firstWhere(
          (plan) =>
              plan.plannedStartDate.isBefore(DateTime.now()) &&
              plan.plannedEndDate.isAfter(DateTime.now()),
          orElse: () {
            throw Exception(
                "No reading plan found for today. Please create a reading plan.");
          },
        );
        return readingPlan;
      }
      return null;
    } catch (e) {
      throw Exception("Error retrieving the current reading plan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<ReadingPlan?>(
        future: _currentReadingPlan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading current reading plan.'));
          }

          final currentReadingPlan = snapshot.data;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First button (Go to Bible)
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BibleBooksScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.book, size: 32),
                      label: Text(
                        'Go to Bible',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Second button (Reading Plan)
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => currentReadingPlan != null
                                ? ViewReadingPlanScreen(
                                    plan: currentReadingPlan)
                                : CreateReadingPlanScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        currentReadingPlan != null
                            ? Icons.edit
                            : Icons.bookmark_add, // Adjust icon dynamically
                        size: 32,
                      ),
                      label: Text(
                        currentReadingPlan != null
                            ? 'View Your Reading Plan'
                            : 'Create Your Reading Plan',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
