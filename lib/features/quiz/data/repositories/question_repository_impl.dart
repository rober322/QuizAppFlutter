import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/question_remote_data_source.dart';

// typedef Future<QuestionsList> _QuestionChooser();

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  QuestionRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, QuestionsList>> getQuestions() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuestion = await remoteDataSource.getQuestions();
        return Right(remoteQuestion);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(IsNotOnlineFailure());
    }
    // return await _getQuestionsList(() {
    //   return remoteDataSource.getQuestions();
    // });
  }

  // Future<Either<Failure, QuestionsList>> _getQuestionsList(
  //   _QuestionChooser getQuestions,
  // ) async {
    
  // }
}