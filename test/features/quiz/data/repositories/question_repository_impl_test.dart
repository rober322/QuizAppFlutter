import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_app/core/error/exception.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/core/network/network_info.dart';
import 'package:quiz_app/features/quiz/data/datasources/question_remote_data_source.dart';
import 'package:quiz_app/features/quiz/data/repositories/question_repository_impl.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';

class MockRemoteDataSource extends Mock
    implements QuestionRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  QuestionRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = QuestionRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getQuestions', () {
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

    final tQuestionsListModel = List<QuestionModel>();
    tQuestionsListModel.add(tQuestionModel1);
    tQuestionsListModel.add(tQuestionModel2);
    final tQuestionsListModelFull = QuestionsListModel(questions: tQuestionsListModel);
  
    final QuestionsList tQuestionsList = tQuestionsListModelFull;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getQuestions();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getQuestions())
              .thenAnswer((_) async => tQuestionsListModelFull);
          // act
          final result = await repository.getQuestions();
          // assert
          verify(mockRemoteDataSource.getQuestions());
          expect(result, equals(Right(tQuestionsList)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getQuestions())
              .thenThrow(ServerException());
          // act
          final result = await repository.getQuestions();
          // assert
          verify(mockRemoteDataSource.getQuestions());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockRemoteDataSource.getQuestions())
              .thenThrow(IsNotOnlineException());
          // act
          final result = await repository.getQuestions();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(IsNotOnlineFailure())));
        },
      );
    });
  });
}