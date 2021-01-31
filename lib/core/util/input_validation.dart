import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputValidation {
  Either<Failure, String> fullNameEntered(String str) {
    if (str == null || str.length == 0) {
      return Left(InvalidInputEmptyFailure());
    } else if (str.length < 3) {
      return Left(InvalidInputLengthFailure());
    }
    
    return Right(str);
  }
}

class InvalidInputEmptyFailure extends Failure {}

class InvalidInputLengthFailure extends Failure {}