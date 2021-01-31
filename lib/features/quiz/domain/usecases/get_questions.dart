
import 'package:dartz/dartz.dart';

import '../entities/question.dart';
import '../repositories/question_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetQuestions extends UseCase<QuestionsList, NoParams> {
  final QuestionRepository repository;

  GetQuestions(this.repository);

  @override
  Future<Either<Failure, QuestionsList>> call(NoParams params) async {
    return await repository.getQuestions();
  }
}