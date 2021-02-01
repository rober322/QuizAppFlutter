import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/domain/usecases/get_questions.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class QuizBloc extends Bloc<QuizEvent, QuizState> {

  final GetQuestions getQuestions;

  QuizBloc({
    @required GetQuestions questions,
  })  : assert(questions != null),
        getQuestions = questions, super(QuizInitial());

  QuizState get initialState => Empty();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is GetQuestionsEvent) {
      yield Loading();
      final failureOrQuestions = await getQuestions(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrQuestions);
    }
  }

  Stream<QuizState> _eitherLoadedOrErrorState(
    Either<Failure, QuestionsList> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (questions) => Loaded(questions: questions),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
