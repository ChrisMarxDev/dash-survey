<p align="center">
  <img src="https://raw.githubusercontent.com/ChrisMarxDev/dash-survey/refs/heads/main/dash_survey/assets/doc/logo.png" width="100">
</p>

# Dash Survey

> ⚠️ **Warning**: This package is under heavy development and the API is subject to breaking changes. 🚧 Use with caution in production environments.

A flexible Flutter package for creating and managing in-app surveys from a remote backend.
Checkout [Dash Survey](dash-survey.com) for more info.

<p align="center">
  <img src="https://raw.githubusercontent.com/ChrisMarxDev/dash-survey/refs/heads/main/dash_survey/assets/doc/dash_survey_preview.png">
</p>

## Features

- 🎯 Easy-to-use surveys
- ☁️ Remote controlled
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
2. As modal bottom sheet on top of your app. This way you can show surveys on top of your current app.

### 1. Native Flutter Survey Element

When using the `DashSurveyBuilder` widget, it will automatically fetch and display surveys that are due to be shown.
If no surveys are available, it will render as SizedBox.shrink().

```dart
import 'package:dash_survey/dash_survey.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         // Content Widgets
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
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

Checkout [Example app](https://github.com/ChrisMarxDev/dash-survey/tree/main/dash_survey/example) for more examples.

### 2. Survey as Modal Bottom Sheet

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
      // Callback to handle any other side effect after successfully submitting a survey
    },
    onCancel: (survey) {
      // Callback to handle any other side effect after the survey was cancelled prematurely
    },
  );
}
```

This function can be called often, as it will not cause any effects, when no survey is available for the user.

<!-- ## Configuration & Targeting -->

<!-- ### Targeting
Dash Survey allows you to  -->

## THE FOLLOWING PARTS OF THE DOCUMENTATION ARE STILL UNDER CONSTRUCTION 🚧

## Themeing 🚧

## Advanced Usage 🚧

Here are some more specific implementation, that highlight how Dash Survey can be configured to match diverse use cases

### Fetch surveys and show specifi UI

### Use Dash Survey to manage App Store ratings

## License

This project is licensed under the Attribution Assurance License - see the [LICENSE](LICENSE) file for details.

The software is provided by Christopher Marx Softwareentwicklung ("Dash Survey") and requires attribution as specified in the license terms. Visit [dash-survey.com](https://dash-survey.com) for more information.
