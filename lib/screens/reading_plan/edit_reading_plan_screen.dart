import 'package:bible_reader_app/models/reading_plan.dart';
import 'package:bible_reader_app/services/hive_service.dart';
import 'package:bible_reader_app/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditReadingPlanScreen extends StatefulWidget {
  final ReadingPlan plan; // The plan that will be edited

  const EditReadingPlanScreen({super.key, required this.plan});

  @override
  _EditReadingPlanScreenState createState() => _EditReadingPlanScreenState();
}

class _EditReadingPlanScreenState extends State<EditReadingPlanScreen> {
  late DateTime _startDate;
  late DateTime _endDate;
  late bool _includeOldTestament;
  late bool _includeApocrypha;
  late bool _includeNewTestament;
  late List<DailyReading> _dailyReadings;

  @override
  void initState() {
    super.initState();
    print(widget.plan);
    _startDate = widget.plan.plannedStartDate; // Use the existing start date
    _endDate = widget.plan.plannedEndDate; // Use the existing end date
    _includeOldTestament = widget.plan.includeOldTestament;
    _includeApocrypha = widget.plan.includeApocrypha;
    _includeNewTestament = widget.plan.includeNewTestament;
    _dailyReadings = widget.plan.dailyReadings;
  }

  Future<void> _savePlan() async {
    // Ensure you're using the correct field names
    final updatedPlan = ReadingPlan()
      ..plannedStartDate = _startDate
      ..plannedEndDate = _endDate
      ..includeOldTestament = _includeOldTestament
      ..includeApocrypha = _includeApocrypha
      ..includeNewTestament = _includeNewTestament
      ..dailyReadings = _dailyReadings;

    // Now save the updated plan
    await HiveService().readingPlanBox.put(updatedPlan.key, updatedPlan);

    // Optionally, navigate back after saving
    Navigator.pop(context, updatedPlan);
  }

  Future<void> _pickStartDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  Future<void> _pickEndDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate, // End date should be after the start date
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Reading Plan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Start date input
            Row(
              children: [
                Text(
                  'Start Date: ${_startDate.toLocal()}'
                      .split(' ')[0], // Format the date
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickStartDate,
                ),
                Text(DateFormat('MMMM dd, yyyy').format(_startDate)),
              ],
            ),
            SizedBox(height: 16),

            // End date input
            Row(
              children: [
                Text(
                  'End Date: ${_endDate.toLocal()}'
                      .split(' ')[0], // Format the date
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickEndDate,
                ),
                Text(DateFormat('MMMM dd, yyyy').format(_endDate)),
              ],
            ),
            ToggleSwitch(
              title: 'Include Old Testament',
              value: _includeOldTestament,
              onChanged: (val) {
                setState(() {
                  _includeOldTestament = val;
                });
              },
            ),
            SizedBox(height: 10),
            ToggleSwitch(
              title: 'Include Apocrypha',
              value: _includeApocrypha,
              onChanged: (val) {
                setState(() {
                  _includeApocrypha = val;
                });
              },
            ),
            SizedBox(height: 10),
            ToggleSwitch(
              title: 'Include New Testament',
              value: _includeNewTestament,
              onChanged: (val) {
                setState(() {
                  _includeNewTestament = val;
                });
              },
            ),
            SizedBox(height: 20),

            // Save button
            Center(
              child: ElevatedButton(
                onPressed: _savePlan,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ), // Trigger save on press
                child: Text('Save Changes', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
