import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/core/util/input_validation.dart';
import '../../../../../lib/features/welcome/presentation/bloc/welcome_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock {}

class MockInputValidation extends Mock implements InputValidation {}

void main() {
  WelcomeBloc bloc;
  MockInputValidation mockInputValidation;

  setUp(() {
    mockInputValidation = MockInputValidation();

    bloc = WelcomeBloc(
      inputValidation: mockInputValidation,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GoToQuiz', () {
    final tFullNameString = 'Rober';

    void setUpMockInputValidationSuccess() =>
      when(mockInputValidation.fullNameEntered(any))
        .thenReturn(Right(tFullNameString));
            
    test(
      'should call the InputValidation to validate the string',
      () async {
        // arrange
        setUpMockInputValidationSuccess();
        // act
        bloc.add(GoToQuiz(tFullNameString));
        await untilCalled(mockInputValidation.fullNameEntered(any));
        // assert
        verify(mockInputValidation.fullNameEntered(tFullNameString));
      },
    );

    test(
      'should emit [Loading, Error] when the input is empty or null',
      () async {
        // arrange
        when(mockInputValidation.fullNameEntered(any))
            .thenReturn(Left(InvalidInputEmptyFailure()));
        // assert later
        final expected = [Loading(), Error(message: INVALID_INPUT_EMPTY_FAILURE_MESSAGE)];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GoToQuiz(tFullNameString));
      },
    );

    test(
      'should emit [Loading, Error] when the string is less than three',
      () async {
        // arrange
        when(mockInputValidation.fullNameEntered(any))
            .thenReturn(Left(InvalidInputLengthFailure()));
        // assert later
        final expected = [Loading(), Error(message: INVALID_INPUT_LENGHT_FAILURE_MESSAGE)];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GoToQuiz(tFullNameString));
      },
    );

    test(
      'should emit [Loading, success] when the string is correct',
      () async {
        // arrange
        when(mockInputValidation.fullNameEntered(any))
            .thenReturn(Right(tFullNameString));
        // assert later
        final expected = [Loading(), Success(fullName: tFullNameString)];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GoToQuiz(tFullNameString));
      },
    );
  });
}
