import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'question_card.dart';
import '../../../../features/quiz/presentation/controllers/question_controller.dart';

class QuizControls extends StatelessWidget {
  const QuizControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Expanded(
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _questionController.pageController,
        onPageChanged: _questionController.updateTheQnNum,
        itemCount: _questionController.questions.length,
        itemBuilder: (context, index) => QuestionCard(
            question: _questionController.questions[index])
      )
    );
  }
}
