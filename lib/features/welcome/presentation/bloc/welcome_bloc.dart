import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/input_validation.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

const String INVALID_INPUT_EMPTY_FAILURE_MESSAGE =
    'Invalid input: No name has been entered';
const String INVALID_INPUT_LENGHT_FAILURE_MESSAGE =
    'Invalid input: name size must be greater than 2.';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final InputValidation inputValidation;

  WelcomeBloc({
    @required this.inputValidation,
  })  : assert(inputValidation != null),
        super(Empty());

  WelcomeState get initialState => Empty();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is GoToQuiz) {
      yield Loading();
      final inputEither = inputValidation.fullNameEntered(event.fullNameString);
      yield inputEither.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (string) => Success(fullName: string),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidInputEmptyFailure:
        return INVALID_INPUT_EMPTY_FAILURE_MESSAGE;
      case InvalidInputLengthFailure:
        return INVALID_INPUT_LENGHT_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
