

import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';

Future<void> showSurveyDialog(
  BuildContext context, {
  required SurveyModel survey,
  required LocaleCode locale,
  void Function(SurveyModel)? onSubmit,
  void Function()? onCancel,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      child: Material(
        type: MaterialType.transparency,
        child: SurveyView(
          locale: locale,
          survey: survey,
          onClose: () {
            Navigator.of(context).pop();
            onCancel?.call();
          },
          onSubmit: (survey) {
            Navigator.of(context).pop();
            onSubmit?.call(survey);
          },
        ),
      ),
    ),
  );
}


