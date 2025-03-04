import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';

part 'survey_model.mapper.dart';

@MappableClass()

/// General survey model, contains all the questions and metadata
class SurveyModel with SurveyModelMappable {
  const SurveyModel({
    required this.id,
    required this.questions,
    required this.name,
    required this.createdAt,
    this.description,
    this.displayOptions,
    this.finishedMessage,
  });

  /// The id of the survey
  final String id;

  /// The name of the survey
  final LocalizedText name;

  /// The optional description of the survey
  final LocalizedText? description;

  /// Sorted list of questions for the survey
  final List<SurveyQuestionModel> questions;

  /// The display options for the survey
  final SurveyDisplayOptionsModel? displayOptions;

  /// The date the survey was created
  final DateTime createdAt;

  /// The message to display when the survey is finished
  final LocalizedText? finishedMessage;
}

@MappableClass()

/// Model for the display configuration of the survey
class SurveyDisplayOptionsModel with SurveyDisplayOptionsModelMappable {
  const SurveyDisplayOptionsModel({
    this.showProgressBar = true,
    this.showQuestionNumber = true,
    this.displayType = SurveyDisplayType.bottomSheet,
    this.indicationType = SurveyIndicationType.floatingButton,
  });

  /// Whether to show the progress bar
  final bool showProgressBar;

  /// Whether to show the question number
  final bool showQuestionNumber;

  /// The display type of the survey
  final SurveyDisplayType displayType;

  /// How a survey is indicated to the user
  final SurveyIndicationType indicationType;
}

@MappableEnum()
enum SurveyDisplayType {
  dialog,
  bottomSheet,
  fullScreen,
}

@MappableEnum()
enum SurveyIndicationType {
  floatingButton,
  popupDialog,
}
