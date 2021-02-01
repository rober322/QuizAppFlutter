import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/domain/usecases/get_questions.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/quiz_bloc.dart';

class MockGetQuestions extends Mock implements GetQuestions {}

void main() {
  QuizBloc bloc;
  MockGetQuestions mockGetQuestions;

  setUp(() {
    mockGetQuestions = MockGetQuestions();

    bloc = QuizBloc(
      questions: mockGetQuestions,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetQuestions', () {
    final tQuestion1 = Question(id: 1, question: "Pregunta 1", answer: 0, options: ["uno", "dos", "tres", "cuatro"]);
    final tQuestion2 = Question(id: 2, question: "Pregunta 2", answer: 1, options: ["uno", "dos", "tres", "cuatro"]);
    final tQuestionlist = List<Question>();
    tQuestionlist.add(tQuestion1);
    tQuestionlist.add(tQuestion2);
    final tQuestionlistFull = QuestionsList(questions: tQuestionlist);

    test(
      'should get data from the questions use case',
      () async {
        // arrange
        when(mockGetQuestions(any))
            .thenAnswer((_) async => Right(tQuestionlistFull));
        // act
        bloc.add(GetQuestionsEvent());
        await untilCalled(mockGetQuestions(any));
        // assert
        verify(mockGetQuestions(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetQuestions(any))
            .thenAnswer((_) async => Right(tQuestionlistFull));
        // assert later
        final expected = [Loading(), Loaded(questions: tQuestionlistFull)];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetQuestionsEvent());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetQuestions(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetQuestionsEvent());
      },
    );
  });
}
