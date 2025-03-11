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

Add `dash_survey` to your `pubspec.yaml` by running:

```bash
flutter pub add dash_survey
```

or add it manually

```yaml
dependencies:
  dash_survey: any
```

Then, import the package in your Dart file and wrap your app in a `DashSurvey` and supply the api key you got from the dashboard at https://app.dash-survey.com

```dart
import 'package:dash_survey/dash_survey.dart';

void main() {
  runApp(DashSurvey(
    apiKey: 'YOUR_API_KEY',
    app: MyApp(),
  ));
}
```

This is also where you can configure your instance of Dash Survey e.g.:

```dart
import 'package:dash_survey/dash_survey.dart';

void main() {
  runApp(DashSurvey(
    apiKey: 'YOUR_API_KEY',
    // manually set the locale to en, instead of the device locale
      overrideLocale: const Locale('en'),
      config: DashSurveyConfig(
        surveyCoolDownInDays: 7,
        skipCoolDownForTargetedViews: true,
        baseUrl: 'https://api.survey-dash.com',
        translationOverrides: const {
          'en': {
            'cancel': 'Cancel',
            'submit': 'Submit',
          },
        },
      ),
      ....
```

<!-- ## Demo Modus

To check the look and feel of DashSurvey, you can use the demo modus.
For that, just pass `demoMode: true` to the `DashSurvey` constructor. -->

## Basic Usage

There are two ways to show a survey:

1. As native element of your app. This way you can show surveys in any widget of your app.
2. As modal on top of your app. This way you can show surveys as a modal on top of your app.

### 1. Native Survey Element

When using the `DashSurveyBuilder` widget, it will automatically fetch and display surveys that are due to be shown.
If no surveys are available, it will render as SizedBox.shrink().

```dart
import 'package:dash_survey/dash_survey.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Title'),
        Card(),
        // ...
        DashSurveyBuilder(),
      ],
    );
  }
}
```

The `DashSurveyBuilder` can be fully customized, to match your app's design. Use the `surveyFrameBuilder` property to style the frame of the survey. Don't forget to return the child Widget, as it contains the actual survey.

```dart
DashSurveyBuilder(
  surveyFrameBuilder: (context, child, surveyState) {
    return Card(
      color: Colors.red,
      child: child,
    );
  },
);
```

You can also display different content based on the survey state.
E.g. when the survey is still loading you display nothing and animate the survey widget in, when a survey is available.
Checkout the different [SurveyState] values for further information.

```dart
DashSurveyBuilder(
  surveyFrameBuilder: (context, child, surveyState) {
     final surveyAvailable = surveyState != SurveyState.loading &&
            surveyState != SurveyState.noSurveyAvailable;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: surveyAvailable
              ? Card(
                  key: const Key('survey-available'),
                  elevation: 4,
                  child: surveyWidget,
                )
              : const SizedBox.shrink(key: Key('survey-not-available')),
        );
  },
);
```

Checkout the [Example app](https://github.com/ChrisMarxDev/dash-survey/tree/main/dash_survey/example) for more examples.

### 2. Survey as Modal

To display a survey as a modal on top of your app, you can use the `DashSurvey.of(context).showNextSurvey()` method.
This will check if there are any surveys that are due to be shown and display the first one.
If no surveys are due to be shown, it will not display anything.

```dart
import 'package:dash_survey/dash_survey.dart';

void main() {
  // Show the survey as a modal
  DashSurvey.of(context).showNextSurvey();
    context,
    onSubmit: (survey) {
      // Handle survey results
    },
    onCancel: (survey) {
      // Handle survey cancellation
    },
  );
}
```

This function can be called often, as it will not cause any effects, when no survey is available for the user.

<!-- ## Configuration & Targeting -->

<!-- ### Targeting
Dash Survey allows you to  -->

## License

This project is licensed under the MIT License - see the LICENSE file for details.
