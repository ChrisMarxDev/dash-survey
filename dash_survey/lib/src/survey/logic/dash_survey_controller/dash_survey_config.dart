class DashSurveyConfig {
  const DashSurveyConfig({
    this.baseUrl,
    this.surveyCoolDownInDays = 7,
    this.skipCoolDownForTargetedViews = true,
  });

  /// Base url or the survey dash api, if not provided the default will be used
  /// Should only be used for self hosted or enterprise customers
  final String? baseUrl;

  /// The cool down time in days between surveys
  /// If not provided the default will be 7 days
  /// This is to prevent the same user from being shown surveys too often.
  ///
  /// This can be disabled by setting it to 0.
  /// Then an eligible user will be shown a new survey every time DashSurvey is
  /// invoked.
  /// In that case only a few surveys should be active at any time.
  final int surveyCoolDownInDays;

  /// If true, the cool down will be skipped for targeted views
  /// This is useful if you want to show a survey in a specific screen
  /// but don't want to wait for valuable user feedback
  /// This is often used for beta testing purposes, so that beta users can
  /// provide feedback directly.
  final bool skipCoolDownForTargetedViews;
}
