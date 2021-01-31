import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/question.dart';

abstract class QuestionRepository {
  Future<Either<Failure, QuestionsList>> getQuestions();
}