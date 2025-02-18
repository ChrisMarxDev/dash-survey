import 'dart:developer';

import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';
import 'sample_content.dart';
import 'theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DashSurvey(
      apiKey: '1efed36e-d900-63f0-a509-6f87ccc16c72',
      config: const DashSurveyConfig(
        baseUrl: String.fromEnvironment(
          'SURVEY_DASH_API_URL',
          defaultValue: 'http://localhost:8080',
        ),
      ),
      child: ThemeRoot(
        child: ThemeConsumer(
          builder: (context, theme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Survey Dash Demo',
              theme: theme,
              home: const HomeScreen(),
            );
          },
        ),
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dashing Furniture'),
          actions: [
            const Icon(Icons.settings),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Survey Dash!'),
            const SizedBox(height: 20),
            const ToggleThemeButton(),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FurnitureStoreHome()),
                );
              },
              child: Text('Furniture Store'),
            ),
            FilledButton(
              onPressed: () {
                DashSurvey.of(context).setUserDimensions({
                  'age': '30',
                  'gender': 'male',
                  'postal_code': '12345',
                });
              },
              child: Text('Set User Params'),
            ),
            FilledButton(
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
            FilledButton(
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
            FilledButton(
              onPressed: () async {
                final survey = await DashSurvey.of(context).getNextSurvey();
                log(survey?.toJson() ?? 'No survey');
              },
              child: Text('Fetch next survey'),
            ),
            FilledButton(
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
