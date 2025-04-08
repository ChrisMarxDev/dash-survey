import 'package:dash_survey/src/survey/survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    this.controller,
    this.focusNode,
    this.onChanged,
    this.hintText,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final String? hintText;
  final int maxLines;
  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;
    final shape = theme.textInputBorder;

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.bodyTextStyle.copyWith(
          color: theme.onDisabledColor,
        ),
        border: shape,
        enabledBorder: shape.copyWith(
          borderSide: BorderSide(color: theme.baseBorderColor),
        ),
        focusedBorder: shape.copyWith(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        errorBorder: shape.copyWith(
          borderSide: BorderSide(color: theme.baseBorderColor),
        ),
        disabledBorder: shape.copyWith(
          borderSide: BorderSide(color: theme.disabledColor),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
