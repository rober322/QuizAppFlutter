part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  
  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}
class Empty extends QuizState{}

class Loading extends QuizState{}

class Loaded extends QuizState{
  final QuestionsList questions;

  Loaded({@required this.questions});
}

class Error extends QuizState{
  final String message;

  Error({@required this.message});
}