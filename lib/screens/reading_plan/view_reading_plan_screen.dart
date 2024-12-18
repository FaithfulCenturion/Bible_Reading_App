import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:bible_reader_app/screens/reading_plan/edit_reading_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewReadingPlanScreen extends StatefulWidget {
  final ReadingPlan plan;

  const ViewReadingPlanScreen({super.key, required this.plan});

  @override
  _ViewReadingPlanState createState() => _ViewReadingPlanState();
}

class _ViewReadingPlanState extends State<ViewReadingPlanScreen> {
  late ReadingPlan _currentPlan;

  @override
  initState() {
    super.initState();
    _currentPlan = widget.plan;
  }

    // Helper function to compare two dates without the time component
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

    // Get today's reading, if available
  DailyReading? _getTodayReading() {
  final today = DateTime.now();
  print(_currentPlan.dailyReadings[0].date);
  // Use where and check if any element exists
  final readings = _currentPlan.dailyReadings.where(
    (reading) => isSameDate(reading.date, today),
  ).toList();

  // If we have any readings, return the first one, otherwise return null
  return readings.isNotEmpty ? readings.first : null;
}

  // Get next week's readings (7 days after today)
  List<DailyReading> _getNextWeekReadings() {
    final today = DateTime.now();
    return _currentPlan.dailyReadings.where((reading) {
      final difference = reading.date.difference(today).inDays;
      return difference > 0 && difference <= 7; // Only next 7 days
    }).toList();
  }

  void _navigateToEditReadingPlanScreen() async {
    final updatePlan = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReadingPlanScreen(plan: _currentPlan),
      ),
    );

    if (updatePlan != null) {
      setState(() {
        _currentPlan = updatePlan;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayReading = _getTodayReading();
    final nextWeekReadings = _getNextWeekReadings();

    // Dynamically build the list of included sections
    final List<String> includedSections = [];
    if (_currentPlan.includeOldTestament) {
      includedSections.add('The Old Testament');
    }
    if (_currentPlan.includeApocrypha) {
      includedSections.add('The Apocrypha');
    }
    if (_currentPlan.includeNewTestament) {
      includedSections.add('The New Testament');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('View Your Reading Plan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Today\'s reading:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            todayReading != null
                ? Card(
                    child: ListTile(
                      title: Text(todayReading.passage),
                      subtitle: Text(DateFormat.yMMMMd().format(todayReading.date)),
                    ),
                  )
                : Text('No reading scheduled for today.'),

            SizedBox(height: 20),

            // Next Week's Reading Section
            Text(
              'Next Week\'s Reading:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            if (nextWeekReadings.isNotEmpty)
              Column(
                children: nextWeekReadings.map((reading) {
                  return Card(
                    child: ListTile(
                      title: Text(reading.passage),
                      subtitle: Text(DateFormat.yMMMMd().format(reading.date)),
                    ),
                  );
                }).toList(),
              )
            else
              Text('No readings scheduled for the next week.'),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToEditReadingPlanScreen,
              child: Text('Edit Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
