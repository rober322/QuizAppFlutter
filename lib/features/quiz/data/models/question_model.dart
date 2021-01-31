import 'package:meta/meta.dart';

import '../../domain/entities/question.dart';

class QuestionsListModel extends QuestionsList {
  final List<QuestionModel> questions;

  QuestionsListModel({
    this.questions,
  });

  factory QuestionsListModel.fromJson(List<dynamic> json) {
    List<QuestionModel> questions = new List<QuestionModel>();
    questions = json.map((i) => QuestionModel.fromJson(i)).toList();

    return new QuestionsListModel(
       questions: questions,
    );
  }

  @override
  List<Object> get props => [questions];
}

class QuestionModel extends Question {
  QuestionModel({
    @required int id,
    @required String question,
    @required int answer,
    @required List<String> options,
  }) : super(id: id, question: question, answer: answer, options: options,);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    var optionsFromJson  = json['options'];
    List<String> optionsList = new List<String>.from(optionsFromJson);
    // List<String> optionsList = optionsFromJson.cast<String>();

    return QuestionModel(
      id: (json['id'] as num).toInt(),
      question: json['question'],
      answer: (json['answer'] as num).toInt(),
      options: optionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'question': question, 'answer': answer, 'options': options,};
  }
}