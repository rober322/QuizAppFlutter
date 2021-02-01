part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
  
  @override
  List<Object> get props => [];
}

class Empty extends WelcomeState{}

class Loading extends WelcomeState{}

class Success extends WelcomeState{
  final String fullName;

  Success({@required this.fullName});
}

class Error extends WelcomeState{
  final String message;

  Error({@required this.message});
}
