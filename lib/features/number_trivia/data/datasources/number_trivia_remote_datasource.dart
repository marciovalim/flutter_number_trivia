import 'package:flutter_number_trivia/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceHttp implements NumberTriviaRemoteDatasource {
  static const _apiBaseUrl = 'http://numbersapi.com';

  final http.Client _client;

  NumberTriviaRemoteDatasourceHttp(this._client);

  @override
  Future<NumberTriviaModel> getNumberTrivia(int number) async {
    return await _getNumberTriviaByPath('$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return await _getNumberTriviaByPath('random');
  }

  Future<NumberTriviaModel> _getNumberTriviaByPath(String path) async {
    final response = await _client.get('$_apiBaseUrl/$path?json');
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(response.body);
    }
    throw ServerException();
  }
}
