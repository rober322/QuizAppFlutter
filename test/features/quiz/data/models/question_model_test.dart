import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tQuestionModel1 = QuestionModel(
      id: 1,
      question: "Pregunta 1",
      answer: 0,
      options: ["Opcion 1", "Opcion 2", "Opcion 3", "Opcion 4"]);
  final tQuestionModel2 = QuestionModel(
      id: 2,
      question: "Pregunta 2",
      answer: 1,
      options: ["Opcion 1", "Opcion 2", "Opcion 3", "Opcion 4"]);

  final tQuestionsList = List<QuestionModel>();
  tQuestionsList.add(tQuestionModel1);
  tQuestionsList.add(tQuestionModel2);
  final tQuestionsListFull = QuestionsListModel(questions: tQuestionsList);

  test(
    'should be a subclass of Question entity',
    () async {
      // assert
      expect(tQuestionModel1, isA<Question>());
    },
  );

  test(
    'should be a subclass of QuestionList entity',
    () async {
      // assert
      expect(tQuestionsListFull, isA<QuestionsList>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid QuestionsList',
      () async {
        // arrange
        final List<dynamic> jsonList = json.decode(fixture('questions.json'));
        // act
        final result = QuestionsListModel.fromJson(jsonList);
        // assert
        expect(result, tQuestionsListFull);
      },
    );

    test(
      'should return a valid QuestionModel',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('question.json'));
        // act
        final result = QuestionModel.fromJson(jsonMap);
        // assert
        expect(result, tQuestionModel1);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tQuestionModel1.toJson();
        // assert
        final expectedJsonMap = {
          "id": 1,
          "question": "Pregunta 1",
          "answer": 0,
          "options": ["Opcion 1", "Opcion 2", "Opcion 3", "Opcion 4"]
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
