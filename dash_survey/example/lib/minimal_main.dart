import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DashSurvey(
      apiKey: 'YOUR_API_KEY',
      child: MaterialApp(
        // Put the [DashSurveyBuilder] widget anywhere
        // to automatically fetch and display surveys
        home: const DashSurveyBuilder(),
      ),
    );
  }
}
