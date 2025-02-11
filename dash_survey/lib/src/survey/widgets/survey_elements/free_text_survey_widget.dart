import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';

class FreeTextSurveyWidget extends StatefulWidget {
  const FreeTextSurveyWidget({
    required this.onChangeAnswer,
    required this.question,
    required this.locale,
    super.key,
    this.placeholder = 'Enter your answer',
    this.answer,
  });

  final String placeholder;
  final void Function(String text) onChangeAnswer;
  final FreetextAnswerModel? answer;
  final FreeTextSurveyQuestion question;
  final LocaleCode locale;
  @override
  State<FreeTextSurveyWidget> createState() => _FreeTextSurveyWidgetState();
}

class _FreeTextSurveyWidgetState extends State<FreeTextSurveyWidget> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textController.text = widget.answer?.answer ?? '';
  }

  @override
  void didUpdateWidget(FreeTextSurveyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer?.answer != null &&
        widget.answer?.answer != textController.text) {
      textController.text = widget.answer!.answer;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: textController,
          focusNode: focusNode,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: widget.onChangeAnswer,
        ),
      ],
    );
  }
}
