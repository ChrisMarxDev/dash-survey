part of 'dash_survey_controller.dart';

class _DashSurveyStoreService {
  _DashSurveyStoreService({required this.sharedPreferencesFuture});

  final Future<SharedPreferences> sharedPreferencesFuture;
  static const dashSurveyCurrentUserIdKey = 'dash_survey_current_user_id';
  static const dashSurveyCompletedSurveysKey = 'dash_survey_completed_surveys';
  static const userTargetDimensionsKey = 'dash_survey_user_target_dimensions';

  Future<String> getUserId() async {
    final sharedPreferences = await sharedPreferencesFuture;
    final userId = sharedPreferences.getString(dashSurveyCurrentUserIdKey);
    if (userId == null) {
      final newUserId = const Uuid().v7();
      await sharedPreferences.setString(dashSurveyCurrentUserIdKey, newUserId);
      return newUserId;
    }
    return userId;
  }

  Future<void> addCompletedSurvey(String surveyId) async {
    final sharedPreferences = await sharedPreferencesFuture;
    final completedSurveys = sharedPreferences.getStringList(
          dashSurveyCompletedSurveysKey,
        ) ??
        [];
    final entry = CompletedSurveyEntry(
      surveyId: surveyId,
      dateTime: DateTime.now(),
    );
    final newCompletedSurveys = [...completedSurveys, entry.toJson()];
    await sharedPreferences.setStringList(
      dashSurveyCompletedSurveysKey,
      newCompletedSurveys,
    );
  }

  Future<List<CompletedSurveyEntry>> getCompletedSurveys() async {
    final sharedPreferences = await sharedPreferencesFuture;
    final completedSurveys = sharedPreferences.getStringList(
          dashSurveyCompletedSurveysKey,
        ) ??
        [];
    return completedSurveys
        .map(CompletedSurveyEntry.fromJson)
        .nonNulls
        .toList();
  }

  Future<void> setUserTargetDimensions(
    Map<String, dynamic> targetDimensions,
  ) async {
    final sharedPreferences = await sharedPreferencesFuture;
    await sharedPreferences.setString(
      userTargetDimensionsKey,
      jsonEncode(targetDimensions),
    );
  }

  Future<Map<String, dynamic>> getUserTargetDimensions() async {
    final sharedPreferences = await sharedPreferencesFuture;
    final targetDimensions =
        sharedPreferences.getString(userTargetDimensionsKey);
    return jsonDecode(targetDimensions ?? '{}') as Map<String, dynamic>;
  }

  Future<void> clear() async {
    final sharedPreferences = await sharedPreferencesFuture;
    await sharedPreferences.remove(dashSurveyCurrentUserIdKey);
    await sharedPreferences.remove(dashSurveyCompletedSurveysKey);
    await sharedPreferences.remove(userTargetDimensionsKey);
  }
}

class CompletedSurveyEntry {
  CompletedSurveyEntry({
    required this.surveyId,
    required this.dateTime,
  });

  final String surveyId;
  final DateTime dateTime;

  String toJson() => jsonEncode({
        'surveyId': surveyId,
        'dateTime': dateTime.toIso8601String(),
      });

  static CompletedSurveyEntry? fromJson(String json) {
    try {
      final jsonMap = jsonDecode(json);
      final surveyId = jsonMap['surveyId'] as String;
      final dateTimeString = jsonMap['dateTime'] as String;
      final dateTime = DateTime.tryParse(dateTimeString);
      if (dateTime == null) {
        throw Exception('Failed to parse date time');
      }
      return CompletedSurveyEntry(
        surveyId: surveyId,
        dateTime: dateTime,
      );
    } catch (e) {
      log('There was an internal error parsing the completed survey entry. '
          'This will likely not cause any issues, since the DashSurvey Cloud '
          'keeps track of completed surveys.');
      return null;
    }
  }
}
