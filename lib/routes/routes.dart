import 'package:flutter/material.dart';

import '../features/quiz/presentation/pages/quiz_page.dart';
import '../features/score/presentation/pages/score_page.dart';
import '../features/welcome/presentation/pages/welcome_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'welcome': (BuildContext context) => WelcomePage(),
    'quiz': (BuildContext context) => QuizPage(),
    'score': (BuildContext context) => ScorePage(),
  };
}