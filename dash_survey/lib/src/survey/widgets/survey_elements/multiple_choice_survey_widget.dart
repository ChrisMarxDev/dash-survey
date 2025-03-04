import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:flutter/material.dart';

class MultipleChoiceSurveyWidget extends StatefulWidget {
  const MultipleChoiceSurveyWidget({
    required this.question,
    required this.onChangeAnswer,
    required this.locale,
    super.key,
    this.isMultiSelect = false,
    this.isRequired = false,
    this.answer,
  });

  final MultipleChoiceSurveyQuestion question;
  final bool isMultiSelect;
  final bool isRequired;
  final void Function(List<String> selectedOptions) onChangeAnswer;
  final MultipleChoiceAnswerModel? answer;
  final LocaleCode locale;
  @override
  State<MultipleChoiceSurveyWidget> createState() =>
      _MultipleChoiceSurveyWidgetState();
}

class _MultipleChoiceSurveyWidgetState
    extends State<MultipleChoiceSurveyWidget> {
  final selectedOptions = <String>{};

  final options = <String, String>{};

  @override
  void initState() {
    super.initState();
    options.addAll(widget.question.options.getMap(widget.locale));
    if (widget.answer != null) {
      selectedOptions.addAll(widget.answer!.answersIds);
    }
  }

  @override
  void didUpdateWidget(covariant MultipleChoiceSurveyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    dashLogInfo('didUpdateWidget ${widget.answer}');

    if (widget.answer != null) {
      final widgetAnswer = Set<String>.from(widget.answer!.answersIds);
      if (selectedOptions.difference(widgetAnswer).isNotEmpty) {
        dashLogInfo(
            'didUpdateWidget ${selectedOptions.difference(widgetAnswer)}');
        selectedOptions
          ..clear()
          ..addAll(widgetAnswer);
      }
    }
    final newOptions = widget.question.options.getMap(widget.locale);
    if (newOptions != options) {
      options
        ..clear()
        ..addAll(newOptions);
    }
  }

  void _handleOptionTap(String optionKey) {
    setState(() {
      if (widget.isMultiSelect) {
        if (selectedOptions.contains(optionKey)) {
          selectedOptions.remove(optionKey);
        } else {
          selectedOptions.add(optionKey);
        }
      } else {
        selectedOptions
          ..clear()
          ..add(optionKey);
      }
    });
    dashLogInfo('Selected $optionKey');
    widget.onChangeAnswer(selectedOptions.toList());
  }

  @override
  Widget build(BuildContext context) {
    dashLogInfo('Rebuild _MultipleChoiceSurveyWidgetState');

    final cardShapeBorder = Theme.of(context).cardTheme.shape;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...options.entries.map((entry) {
          final optionKey = entry.key;
          final text = entry.value;
          final isSelected = selectedOptions.contains(optionKey);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              margin: EdgeInsets.zero,
              child: InkWell(
                customBorder: cardShapeBorder,
                onTap: () => _handleOptionTap(optionKey),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (widget.isMultiSelect)
                        Checkbox(
                          value: isSelected,
                          onChanged: (_) => _handleOptionTap(optionKey),
                        )
                      else
                        Radio<bool>(
                          value: true,
                          groupValue: isSelected,
                          onChanged: (_) => _handleOptionTap(optionKey),
                        ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(text)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
