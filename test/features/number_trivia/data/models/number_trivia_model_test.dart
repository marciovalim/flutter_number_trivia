import 'dart:convert';

import 'package:flutter_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tText = "this is a text of test";
  final tNumber = 1;
  final tResultFromApi = json.encode({
    "text": tText,
    "number": tNumber,
  });

  group('number_trivia_model', () {
    test('number_trivia_model.fromJson should return an instance of itself',
        () {
      final numberTriviaModel = NumberTriviaModel.fromJson(tResultFromApi);

      final expected = NumberTriviaModel(number: tNumber, text: tText);
      expect(numberTriviaModel, expected);
    });

    test('number_triva_model.toJson should return a json encoded of itself',
        () {
      final numberTriviaModel = NumberTriviaModel.fromJson(tResultFromApi);

      final result = numberTriviaModel.toJson();

      expect(result, tResultFromApi);
    });

    test('number_trivia_model is subclass of number_trivia entity', () {
      final numberTriviaModel = NumberTriviaModel.fromJson(tResultFromApi);

      expect(numberTriviaModel, isA<NumberTrivia>());
    });
  });
}
