import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/loading_questions_widget.dart';
import 'package:quiz_app/features/welcome/presentation/widgets/loading_widget.dart';
import 'package:quiz_app/features/welcome/presentation/widgets/message_display.dart';

import '../../../../injection_container.dart';
import '../../../../constants.dart';
import '../../../../core/widgets/fondo_svg.dart';
import '../../../../features/quiz/presentation/widgets/progress_bar.dart';
import '../../../../features/quiz/presentation/widgets/quiz_controls.dart';
import '../../../../features/quiz/presentation/widgets/title_quiz.dart';
import '../../../../features/quiz/presentation/controllers/question_controller.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/quiz_bloc.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    QuestionController questionController = Get.put(QuestionController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: questionController.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: buildBody(context, name, questionController),
    );
  }

  BlocProvider<QuizBloc> buildBody(BuildContext context, String name, QuestionController questionController) {
    return BlocProvider(
      create: (_) => sl<QuizBloc>(),
      child: Stack(children: [
        FondoSvg(),
        BlocBuilder<QuizBloc, QuizState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is Empty || state == null) {
              print('Iniciando!');
              return LoadingQuestionsWidget();
            } else if (state is Loading) {
              print('Cargando!');
              return Text('');
            } else if (state is Loaded) {
              print('Success');
              return QuizControls(name, state.questions);
            } else if (state is Error) {
              print('Error!');
              return MessageDisplay(
                message: state.message,
              );
            }
          },
        ),
      ]),
    );
  }
}
