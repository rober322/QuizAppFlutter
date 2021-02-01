import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../core/widgets/fondo_svg.dart';
import '../../../../features/quiz/presentation/widgets/progress_bar.dart';
import '../../../../features/quiz/presentation/widgets/quiz_controls.dart';
import '../../../../features/quiz/presentation/widgets/title_quiz.dart';
import '../../../../features/quiz/presentation/controllers/question_controller.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    QuestionController _questionController = Get.put(QuestionController(context: context));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Quiz"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _questionController.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: Stack(
        children: [
          FondoSvg(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressBar(),
                SizedBox(height: kDefaultPadding),
                TitleQuiz(name: name),
                Divider(thickness: 2),
                SizedBox(height: kDefaultPadding),
                QuizControls()
              ]
            )
          )
        ]
      )
    );
  }
}
