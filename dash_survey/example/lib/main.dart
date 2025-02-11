import 'dart:developer';

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
      apiKey: 'demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      child: MaterialApp(
        title: 'SurveyDash Demo',
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          spacing: 16,
          children: [
            ElevatedButton(
              onPressed: () {
                DashSurvey.of(context).setUserParams({
                  'name': 'John Doe',
                  'postal_code': '12345',
                  'email': 'john.doe@example.com',
                });
              },
              child: Text('Set User Params'),
            ),
            ElevatedButton(
              onPressed: () {
                DashSurvey.of(context).showNextSurvey(
                  onComplete: (survey) {
                    print('Survey complete: ${survey.id}');
                  },
                  onCancel: () {
                    print('Survey cancelled');
                  },
                );
              },
              child: Text('Show next survey'),
            ),
            ElevatedButton(
              onPressed: () {
                DashSurvey.showDemo(
                  context: context,
                  // displayType: SurveyDisplayType.bottomSheet,
                  // onComplete: (survey) {
                  //   print('Survey complete: ${survey.id}');
                  // },
                  // onCancel: () {
                  //   print('Survey cancelled');
                  // },
                );
              },
              child: Text('Show demo survey'),
            ),
            ElevatedButton(
              onPressed: () async {
                final survey =
                    await DashSurvey.of(context).fetchNextSurveyObject();
                log(survey?.toJson() ?? 'No survey');
              },
              child: Text('Fetch next survey'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SurveyElementsScreen()),
                );
              },
              child: Text('Survey Elements'),
            ),
          ],
        ));
  }
}

class SurveyElementsScreen extends StatelessWidget {
  const SurveyElementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text('Survey Elements'),
          for (final question in exampleQuestions)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SurveyQuestionView(question: question, locale: LocaleCode.en),
                  Divider(height: 16, thickness: 2, color: Colors.grey),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DashSurveyElementScreen extends StatelessWidget {
  const DashSurveyElementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DashSurveyBuilder(),
    );
  }
}
