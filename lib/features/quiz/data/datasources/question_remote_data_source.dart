import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/core/util/json_util.dart';

import '../models/question_model.dart';
import '../../../../core/error/exception.dart';

abstract class QuestionRemoteDataSource {
  Future<QuestionsListModel> getQuestions();
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final http.Client client;

  QuestionRemoteDataSourceImpl({@required this.client});

  @override
  Future<QuestionsListModel> getQuestions() =>
      _getQuestionsFromUrl('http://private-dd7db-srv1.apiary-mock.com/questions');

  Future<QuestionsListModel> _getQuestionsFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return QuestionsListModel.fromJson(jsonDecodeUtf8(response.bodyBytes));
    } else {
      throw ServerException();
    }
  }
}