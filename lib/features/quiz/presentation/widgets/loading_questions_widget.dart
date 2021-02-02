import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiz_app/features/quiz/presentation/bloc/quiz_bloc.dart';

class LoadingQuestionsWidget extends StatelessWidget {
  const LoadingQuestionsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuizBloc>(context).add(GetQuestionsEvent());
    print("LoadingQuestionsWidget");
    return Column(children: [
      Spacer(),
      Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      SizedBox(height: 5),
      Text("Cargando..."),
      Spacer(),
    ]);
  }
}
