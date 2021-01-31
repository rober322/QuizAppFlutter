import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/util/input_validation.dart';

void main() {
  InputValidation inputValidation;

  setUp(() {
    inputValidation = InputValidation();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return a string when a full name is entered ',
      () async {
        // arrange
        final str = 'rober';
        // act
        final result = inputValidation.fullNameEntered(str);
        // assert
        expect(result, Right('rober'));
      },
    );

    test(
      'should return a failure empty when the string is empty',
      () async {
        // arrange
        final str = '';
        // act
        final result = inputValidation.fullNameEntered(str);
        // assert
        expect(result, Left(InvalidInputEmptyFailure()));
      },
    );

    test(
      'should return a failure empty when the string is null',
      () async {
        // arrange
        final str = null;
        // act
        final result = inputValidation.fullNameEntered(str);
        // assert
        expect(result, Left(InvalidInputEmptyFailure()));
      },
    );

    test(
      'should return a length error when the string is less than three',
      () async {
        // arrange
        final str = 'ro';
        // act
        final result = inputValidation.fullNameEntered(str);
        // assert
        expect(result, Left(InvalidInputLengthFailure()));
      },
    );
  });
}