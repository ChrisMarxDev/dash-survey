/// State of the survey builder, used to determine the next widget to show.
enum SurveyState {
  /// DashSurvey is still determining if there is a survey
  loading,

  /// No survey is currently available for the user
  noSurveyAvailable,

  /// Currently showing an active survey to the user
  activeSurvey,

  /// The user has submitted their survey answers
  surveySubmitted,

  /// The survey has been closed submission
  surveyClosed,
}
