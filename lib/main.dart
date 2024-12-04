import 'package:bible_reader_app/screens/home_screen.dart';
import 'package:bible_reader_app/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter bindings are initialized before Hive

  // Initialize Hive
  await HiveService().init(); // Open the Hive box

  // Open the box explicitly
  await HiveService().openReadingPlanBox();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bible+ Reader',
        theme: ThemeData(
          // This is the theme of your application.
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 12, 57, 182)),

          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}
