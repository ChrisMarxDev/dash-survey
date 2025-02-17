import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';
import 'package:dash_survey_core/src/util/internal_logger.dart';
import 'package:http/http.dart' as http;

/// This is the API client for the DashSurveyCloud server.
class DashSurveyApi {
  /// Create a new DashSurveyApi instance.
  /// The [baseUrl] is the base URL of the survey dash API. Normally this is
  /// the URL of the DashSurveyCloud server.
  /// However, we are leaving this open for proxying or future self hosting.
  /// The [apiKey] is the API key of the organization.
  /// This can be found in the DashSurveyCloud dashboard.
  DashSurveyApi(String baseUrl, String apiKey)
      : assert(baseUrl.isNotEmpty, 'baseUrl must not be empty'),
        assert(apiKey.isNotEmpty, 'apiKey must not be empty'),
        _baseUrl = baseUrl,
        _apiKey = apiKey;

  final String _baseUrl;
  final String _apiKey;
  final bool _logRequests = true;

  final http.Client _client = http.Client();

  Uri _url(String path, [Map<String, String>? queryParameters]) {
    final uri = Uri.parse(_baseUrl + path);
    final uriParams = uri.queryParameters;
    final newUri = uri.replace(
      queryParameters: {
        ...uriParams,
        if (queryParameters != null) ...queryParameters,
      },
    );
    return newUri;
  }

  Map<String, String> get _authHeader => {
        'X-API-Key': _apiKey,
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        // 'Origin': _baseUrl,
      };

  Future<Res> _post<Req extends Object, Res extends Object>(
    String path,
    Req body,
    ClassMapperBase<Req>? requestMapper,
    ClassMapperBase<Res>? responseMapper, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final url = _url(path, queryParameters);
    final requestBody = requestMapper?.encodeJson(body) ?? jsonEncode(body);

    final requestHeaders = {
      ..._authHeader,
      ...?headers,
    };
    logInfo('POST Request: $url\n$requestBody\n$requestHeaders');
    final response = await _client.post(
      url,
      headers: requestHeaders,
      body: requestBody,
    );

    _checkResponseForError(response);
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final result = responseMapper?.decodeMap<Res>(json) ?? json as Res;
    return result;
  }

  // Future<Res> _get<Res extends Object>(
  //   String path,
  //   ClassMapperBase<Res> responseMapper, {
  //   Map<String, String>? headers,
  //   Map<String, String>? queryParameters,
  // }) async {
  //   final url = _url(path, queryParameters);
  //   final requestHeaders = {
  //     ..._authHeader,
  //     ...?headers,
  //   };
  //   final response = await _client.get(url, headers: requestHeaders);
  //   _checkResponseForError(response);
  //   final json = jsonDecode(response.body) as Map<String, dynamic>;
  //   final result = responseMapper.decodeMap<Res>(json);
  //   return result;
  // }

  void _checkResponseForError(http.Response response) {
    if (response.statusCode >= 400 && response.statusCode < 600) {
      if (_logRequests) {
        print(
          'Error: status ${response.statusCode} Response: ${response.body}',
        );
      }
      throw Exception(response.body);
    }
  }

  Future<List<Res>> _getList<Res extends Object>(
    String path,
    ClassMapperBase<Res> responseMapper, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final url = _url(path, queryParameters);

    logInfo('GET List: $url');
    final requestHeaders = {
      ..._authHeader,
      ...?headers,
    };
    logInfo('Request Headers: $requestHeaders');
    final response = await _client.get(url, headers: requestHeaders);
    logInfo('Response: ${response.body}');
    _checkResponseForError(response);
    final json = jsonDecode(response.body) as List<dynamic>;
    final result = json
        .map((e) => responseMapper.decodeMap<Res>(e as Map<String, dynamic>))
        .toList();
    return result;
  }

  /// Get all surveys that the user is elligle for.
  /// Caution the backend also keeps track of which surveys the user has
  /// completed and wont return surveys that the user has already completed.
  Future<List<SurveyModel>> getElliglbeOpenSurveys({
    required String userId,
    required LocaleCode localeCode,
    required Map<String, dynamic> targetDimensions,
  }) async {
    try {
      final surveys = await _getList<SurveyModel>(
        '/v1/survey',
        SurveyModelMapper.ensureInitialized(),
        queryParameters: {
          'userId': userId,
          'localeCode':
              localeCode.toString(), // Ensure localeCode is converted to string
        },
      );
      return surveys;
    } catch (e, stack) {
      logInfo('Error fetching surveys: $e\n$stack'); // Add better error logging
      rethrow;
    }
  }

  /// Post the answers to a survey.
  /// This will save the answers to the database.
  Future<void> postSurveyAnswers(
    String surveyId,
    String userId,
    List<SurveyAnswerModel> answers,
  ) async {
    assert(answers.isNotEmpty, 'Answers must not be empty');
    final completeAnswers = SubmitSurveyAnswerModel(
      answers: answers,
      surveyId: surveyId,
      userId: userId,
    );
    await _post<SubmitSurveyAnswerModel, Map<String, dynamic>>(
      '/v1/survey/answer/$surveyId',
      completeAnswers,
      SubmitSurveyAnswerModelMapper.ensureInitialized(),
      null,
    );
  }
}
