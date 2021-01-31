import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/quiz/domain/repositories/question_repository.dart';
import 'package:quiz_app/features/quiz/domain/usecases/get_questions.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';

class MockQuestionRepository extends Mock
    implements QuestionRepository {}

void main() {
  GetQuestions usecase;
  MockQuestionRepository mockQuestionRepository;

  setUp(() {
    mockQuestionRepository = MockQuestionRepository();
    usecase = GetQuestions(mockQuestionRepository);
  });

  final tQuestion1 = Question(id: 1, question: "Pregunta 1", answer: 1, options: ["uno", "dos", "tres", "cuatro"]);
  final tQuestion2 = Question(id: 1, question: "Pregunta 1", answer: 1, options: ["uno", "dos", "tres", "cuatro"]);
  final tQuestionlist = List<Question>();
  tQuestionlist.add(tQuestion1);
  tQuestionlist.add(tQuestion2);
  final tQuestionlistFull = QuestionsList(questions: tQuestionlist);

  test(
    'should get question from the repository',
    () async {
      // arrange
      when(mockQuestionRepository.getQuestions())
          .thenAnswer((_) async => Right(tQuestionlistFull));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tQuestionlistFull));
      verify(mockQuestionRepository.getQuestions());
      verifyNoMoreInteractions(mockQuestionRepository);
    },
  );
}