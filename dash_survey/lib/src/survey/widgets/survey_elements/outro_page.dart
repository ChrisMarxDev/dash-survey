import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/build_context_extension.dart';
import 'package:flutter/widgets.dart';

class SurveyThankYouView extends StatelessWidget {
  const SurveyThankYouView({
    required this.survey,
    required this.locale,
    super.key,
  });

  final SurveyModel survey;
  final LocaleCode locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            survey.finishedMessage?.get(locale) ??
                context.getTranslatedString('survey_finished'),
          ),
        ),
      ],
    );
  }
}
