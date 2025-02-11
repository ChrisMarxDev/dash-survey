import 'package:dash_survey_core/dash_survey_core.dart';
import 'package:flutter/widgets.dart';

class BasicSurveyWidget extends StatelessWidget {
  const BasicSurveyWidget({
    required this.onSubmit,
    super.key,
    this.child,
    this.question,
    this.answer,
  });

  final Widget? child;
  final SurveyQuestionModel? question;
  final SurveyAnswerModel? answer;
  final void Function(SurveyQuestionModel question) onSubmit;

  @override
  Widget build(BuildContext context) {
    // switch (question) {
    //   case FreeTextSurveyQuestion():
    //     return FreeTextSurveyWidget(
    //       title: question?.title ?? '',
    //       onSubmit: (value) {
    //         onSubmit(question!);
    //       },
    //     );
    // }
    return Container();
  }
}
