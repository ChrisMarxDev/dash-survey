import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';

extension _SliderSurveyWidgetExtension on List<String> {
  List<String> fillUntilIndex(
    int end,
    String Function(int index) valueFunction,
  ) {
    final slots = end - length;
    if (slots > 0) {
      for (var i = length; i < end; i++) {
        add(valueFunction(i));
      }
    }
    return this;
  }
}

class ScaleSurveyWidget extends StatelessWidget {
  const ScaleSurveyWidget({
    required this.onChangeAnswer,
    required this.question,
    required this.locale,
    super.key,
    this.answer,
  });

  final void Function(double) onChangeAnswer;
  final ScaleAnswerModel? answer;
  final ScaleSurveyQuestion question;
  final LocaleCode locale;

  @override
  Widget build(BuildContext context) {
    if (question.scaleType == ScaleType.slider) {
      return _SliderSurveyWidget(
        onChangeAnswer: onChangeAnswer,
        answer: answer,
        question: question,
        locale: locale,
      );
    }
    return _ScaleSurveyWidgetBase(
      onChangeAnswer: onChangeAnswer,
      answer: answer,
      question: question,
      locale: locale,
    );
  }
}

class _SliderSurveyWidget extends StatefulWidget {
  const _SliderSurveyWidget({
    required this.onChangeAnswer,
    required this.question,
    required this.locale,
    this.answer,
  });

  final void Function(double) onChangeAnswer;
  final ScaleAnswerModel? answer;
  final ScaleSurveyQuestion question;
  final LocaleCode locale;
  @override
  State<_SliderSurveyWidget> createState() => _SliderSurveyWidgetState();
}

class _SliderSurveyWidgetState extends State<_SliderSurveyWidget> {
  double? _value;

  final max = 100.0;
  final min = 0.0;

  String labelForValue(double value, List<String> labels) {
    //   get the label for the given value e.g. with 3 labels:
    //   0-33 label 1, 34-66 label 2, 67-100 label 3
    final stepSize = max / labels.length;
    final index = ((value - stepSize / 2) / stepSize).round();
    final clampedIndex = index.clamp(0, labels.length - 1);
    return labels[clampedIndex];
  }

  @override
  Widget build(BuildContext context) {
    final labels = widget.question.options.get(widget.locale)
      ..fillUntilIndex(2, (index) => '');

    final activeValue = _value ?? 50;
    final isSet = _value != null;
    final activeColor = context.theme.primaryColor;
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              sliderTheme: const SliderThemeData(
                trackHeight: 8,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                  elevation: 0,
                ),
              ),
            ),
            child: Slider(
              // inactiveColor: ColorTheme.divider,
              activeColor:
                  isSet ? activeColor : activeColor.withValues(alpha: .5),
              value: activeValue,
              min: min,
              max: max,
              divisions: 100,
              label: labelForValue(activeValue, labels),
              onChanged: (value) {
                setState(() {
                  _value = value;
                });

                widget.onChangeAnswer.call(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labels[0],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  labels.last,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleSurveyWidgetBase extends StatefulWidget {
  const _ScaleSurveyWidgetBase({
    required this.onChangeAnswer,
    required this.question,
    required this.locale,
    // this.scaleWidgetBuilder,
    this.answer,
  });

  final void Function(double) onChangeAnswer;
  final ScaleAnswerModel? answer;
  final ScaleSurveyQuestion question;
  final LocaleCode locale;
  // TODO(chris): add custom scale widget builder
  // final Widget Function(
  // BuildContext context, {
  // required int index,
  // required bool isSelected,
  // })? scaleWidgetBuilder;

  @override
  State<_ScaleSurveyWidgetBase> createState() => _ScaleSurveyWidgetBaseState();
}

class _ScaleSurveyWidgetBaseState extends State<_ScaleSurveyWidgetBase> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.answer?.answer.toInt();
  }

  @override
  void didUpdateWidget(covariant _ScaleSurveyWidgetBase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer?.answer != oldWidget.answer?.answer) {
      setState(() {
        _selectedIndex = widget.answer?.answer.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final label1 = widget.question.options.get(widget.locale).firstOrNull ?? '';
    final label2 = widget.question.options.get(widget.locale).lastOrNull ?? '';

    final outlineButtonShape = context.theme.cardElementShape;
    final theme = context.theme;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label1,
                style: theme.bodyStyle,
              ),
              Text(
                label2,
                style: theme.bodyStyle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              for (var i = 0; i < 5; i++)
                Expanded(
                  child: Center(
                    child: InkWell(
                      customBorder: outlineButtonShape,
                      onTap: () {
                        setState(() {
                          _selectedIndex = i;
                        });
                        widget.onChangeAnswer.call(i.toDouble());
                      },
                      child: ScaleButton(
                        label: '${i + 1}',
                        isSelected: _selectedIndex == i,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScaleButton extends StatelessWidget {
  const ScaleButton({
    required this.label,
    super.key,
    this.isSelected = false,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    // final outlinedButtonStyle = Theme.of(context).outlinedButtonTheme.style;
    final theme = context.theme;
    final shape = theme.cardElementShape ?? const RoundedRectangleBorder();
    final primaryColor = context.theme.primaryColor;

    final backgroundColor =
        isSelected ? primaryColor : primaryColor.withValues(alpha: 0);
    // final borderColor = primaryColor;
//
    // final foregroundColor =
    // isSelected ? context.theme.onPrimaryColor : primaryColor;

    // final mergedShape = shape?.copyWith(side: borderSide);
    return AnimatedContainer(
      constraints: const BoxConstraints(
        minHeight: 44,
        maxWidth: 86,
      ),
      duration: const Duration(milliseconds: 300),
      decoration: ShapeDecoration(
        shape: shape,
        color: backgroundColor,
      ),
      child: Center(
        child: Text(label, style: theme.buttonTextStyle),
      ),
    );
  }
}
