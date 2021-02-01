part of 'welcome_bloc.dart';

abstract class WelcomeEvent {}

class GoToQuiz extends WelcomeEvent {
  final String fullNameString;

  GoToQuiz(this.fullNameString);
}