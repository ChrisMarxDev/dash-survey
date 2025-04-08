import 'dart:developer';

import 'package:dash_survey/dash_survey.dart';
import 'package:example/survey_elements.dart';
import 'package:flutter/material.dart';
import 'sample_content.dart';
import 'theme_provider.dart';

class Env {
  static const surveyDashApiKey = String.fromEnvironment('SURVEY_DASH_API_KEY');
  static const surveyDashBaseUrl =
      String.fromEnvironment('SURVEY_DASH_API_URL');
}

void main() {
  final apiKey = Env.surveyDashApiKey;
  final baseUrl = Env.surveyDashBaseUrl;

  // Add debug prints
  print('Debug: API Key = $apiKey');
  print('Debug: Base URL = $baseUrl');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiKey = Env.surveyDashApiKey;
    final baseUrl = Env.surveyDashBaseUrl;

    final theme = DashSurveyThemeData(
      useMaterialTheme: false,
      primaryColor: const Color(0xff1c63f2), // _defaultPrimaryColor
      onPrimaryColor: Colors.white, // _defaultOnPrimaryColor
      disabledColor: const Color(0xFFE2E8F0), // _defaultDisabledColor
      onDisabledColor: const Color(0xFF94A3B8), // _defaultOnDisabledColor
      backgroundColor: Colors.white, // _defaultBackgroundColor
      onBackgroundColor: const Color(0xFF1E293B), // _defaultOnBackgroundColor
      interactiveElementBackgroundColor:
          Colors.white, // _defaultInteractiveElementBackgroundColor
      interactiveElementShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFe2e8f0)), // _defaultBorderColor
      ),
      buttonShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side:
            const BorderSide(color: Colors.transparent), // _defaultBorderColor
      ),
      textInputBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFFe2e8f0)), // _defaultBorderColor
      ),
      buttonPadding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // _defaultButtonPadding
    );
    return DashSurvey(
      apiKey: apiKey,
      // manually set the locale to en, instead of the device locale
      overrideLocale: const Locale('en'),
      debugMode: true,
      theme: theme,
      config: DashSurveyConfig(
        surveyCoolDownInDays: 7,
        skipCoolDownForTargetedViews: true,
        baseUrl: baseUrl,
        translationOverrides: const {
          'en': {
            'cancel': 'Cancel',
            'submit': 'Submit',
          },
        },
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
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                  'Welcome to Survey Dash! API Key: ${String.fromEnvironment('SURVEY_DASH_API_KEY')}'),
            ),
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
                    log('Survey complete: ${survey.id}');
                  },
                  onCancel: () {
                    log('Survey cancelled');
                  },
                );
              },
              child: Text('Show next survey'),
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
