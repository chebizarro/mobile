import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'steps/take_sell_order_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp(r'features/.*\.feature')]
    ..reporters = [
      StdoutReporter(),
      ProgressReporter(),
      TestRunSummaryReporter(),
    ]
    ..stepDefinitions = TakeSellOrderSteps.steps
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  return GherkinRunner().execute(config);
}
