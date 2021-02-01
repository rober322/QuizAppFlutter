import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../features/quiz/presentation/controllers/question_controller.dart';

class TitleQuiz extends StatelessWidget {
  const TitleQuiz({Key key, @required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Obx(() => Text.rich(
          TextSpan(
            text: "Pregunta ${_questionController.questionNumber.value}",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: kSecondaryColor),
            children: [
              TextSpan(
                text: " / ${_questionController.questions.length} - $name",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: kSecondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
