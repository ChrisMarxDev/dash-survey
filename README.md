# Dash Survey

A flexible Flutter package for creating and managing in-app surveys with a clean, material design-inspired interface.

## Features

- 🎯 Easy-to-use survey creation API
- 📱 Material Design UI components
- 💾 Built-in persistence support
- 🔄 Customizable survey flow
- 📊 Multiple question types support
- 🎨 Customizable theming

## Getting Started

Add `dash_survey` to your `pubspec.yaml`:

```yaml
dependencies:
  dash_survey: ^1.0.0
```

Then, import the package in your Dart file and wrap your app in a `DashSurvey` and supply the api key you got from the dashboard at https://app.dash-survey.com

```dart
import 'package:dash_survey/dash_survey.dart';

void main() {
  runApp(DashSurvey(
    apiKey: 'your-api-key',
    app: MyApp(),
  ));
}
```

<!-- ## Demo Modus

To check the look and feel of DashSurvey, you can use the demo modus.
For that, just pass `demoMode: true` to the `DashSurvey` constructor. -->


## Basic Usage

### Creating a Simple Survey

```dart
import 'package:dash_survey/dash_survey.dart';

void main() {
  // Show the survey
  DashSurvey.show(
    context,
    survey: survey,
    onComplete: (results) {
      // Handle survey results
      print(results);
    },
  );
}
```

### Configuring Survey Behavior

```dart
DashSurvey.show(
  context,
  survey: survey,
  config: SurveyConfig(
    persistence: true,  // Enable local storage
    skipEnabled: true,  // Allow skipping questions
    showProgressBar: true,
  ),
  theme: SurveyTheme(
    primaryColor: Colors.blue,
    backgroundColor: Colors.white,
    textColor: Colors.black87,
  ),
);
```

## Advanced Usage

### Custom Question Types

```dart
final customQuestion = Question(
  id: 'custom_input',
  text: 'Select your preferred options',
  type: QuestionType.multiSelect,
  options: [
    'Option A',
    'Option B',
    'Option C',
  ],
  validation: (value) {
    if (value == null || (value as List).isEmpty) {
      return 'Please select at least one option';
    }
    return null;
  },
);
```

### Persistence Configuration

```dart
final persistenceService = SurveyPersistenceService(
  storage: SharedPreferencesStorage(),
  expirationDuration: Duration(days: 30),
);

DashSurvey.show(
  context,
  survey: survey,
  config: SurveyConfig(
    persistence: true,
    persistenceService: persistenceService,
  ),
);
```

## Question Types

- `text`: Free-form text input
- `rating`: Star rating (1-5)
- `singleSelect`: Single choice from multiple options
- `multiSelect`: Multiple choices from options
- `boolean`: Yes/No questions
- `scale`: Numeric scale (customizable range)

## Customization

### Theming

```dart
final theme = SurveyTheme(
  primaryColor: Colors.purple,
  backgroundColor: Colors.grey[100],
  textColor: Colors.black87,
  buttonStyle: ButtonStyle(...),
  inputDecoration: InputDecoration(...),
);
```

### Custom Widgets

```dart
DashSurvey.show(
  context,
  survey: survey,
  customWidgets: {
    'custom_rating': (context, question, onChange) {
      return CustomRatingWidget(
        initialValue: question.value,
        onChanged: onChange,
      );
    },
  },
);
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

```

This README provides a comprehensive overview of the package's features and usage patterns. It includes:

1. A brief introduction and feature list
2. Installation instructions
3. Basic usage examples
4. Advanced usage scenarios
5. Available question types
6. Customization options
7. Contributing and license information

The examples demonstrate common use cases while keeping the code snippets concise and easy to understand. Users can quickly get started with basic implementation and then explore more advanced features as needed.
```
