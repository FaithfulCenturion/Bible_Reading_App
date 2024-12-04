import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:bible_reader_app/screens/reading_plan/edit_reading_plan_screen.dart';
import 'package:flutter/material.dart';

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
    // Dynamically build the list of included sections
    final List<String> includedSections = [];
    print(_currentPlan);
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
            SizedBox(height: 20),
            Text('Content goes here'),
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
