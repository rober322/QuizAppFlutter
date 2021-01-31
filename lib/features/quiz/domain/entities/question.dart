import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class QuestionsList extends Equatable {
  final List<Question> questions;

  const QuestionsList({
    @required this.questions
  });

  @override
  List<Object> get props => [questions];
}

class Question extends Equatable {
  final int id;
  final String question;
  final int answer;
  final List<String> options;

  const Question({
    @required this.id,
    @required this.question,
    @required this.answer,
    @required this.options
  });

  @override
  List<Object> get props => [id, question, answer, options];
}

