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
      selectedOptions.addAll(widget.answer!.answers);
    }
  }

  @override
  void didUpdateWidget(covariant MultipleChoiceSurveyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    logInfo('didUpdateWidget ${widget.answer}');

    if (widget.answer != null) {
      final widgetAnswer = Set<String>.from(widget.answer!.answers);
      if (selectedOptions.difference(widgetAnswer).isNotEmpty) {
        logInfo('didUpdateWidget ${selectedOptions.difference(widgetAnswer)}');
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
    logInfo('Selected $optionKey');
    widget.onChangeAnswer(selectedOptions.toList());
  }

  @override
  Widget build(BuildContext context) {
    logInfo('Rebuild _MultipleChoiceSurveyWidgetState');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...options.entries.map((entry) {
          final optionKey = entry.key;
          final text = entry.value;
          final isSelected = selectedOptions.contains(optionKey);
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: InkWell(
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
          );
        }),
      ],
    );
  }
}
