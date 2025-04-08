import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SurveyQuestionView(
                        question: question, locale: LocaleCode.en),
                    const SizedBox(height: 16),
                    SurveyButtonRow(
                        onPrevious: () {},
                        previousButtonText: 'Previous',
                        onNext: () {},
                        nextButtonText: 'Next')
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
