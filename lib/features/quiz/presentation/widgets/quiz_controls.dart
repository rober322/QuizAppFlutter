import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import 'question_card.dart';
import '../../../../features/quiz/presentation/controllers/question_controller.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/progress_bar.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/title_quiz.dart';

class QuizControls extends StatefulWidget {
  final String name;
  final QuestionsList questions;

  const QuizControls(this.name, this.questions, {Key key}) : super(key: key);

  @override
  _QuizControlsState createState() => _QuizControlsState();
}

class _QuizControlsState extends State<QuizControls> {
  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    _questionController.context = context;
    _questionController.questions = widget.questions.questions;
    
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ProgressBar(),
      SizedBox(height: kDefaultPadding),
      TitleQuiz(name: widget.name),
      Divider(thickness: 2),
      SizedBox(height: kDefaultPadding),
      SizedBox(
        height: 360,
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _questionController.pageController,
            onPageChanged: _questionController.updateTheQnNum,
            itemCount: widget.questions.questions.length,
            itemBuilder: (context, index) =>
                QuestionCard(question: widget.questions.questions[index])),
      ),
    ]);
  }
}
