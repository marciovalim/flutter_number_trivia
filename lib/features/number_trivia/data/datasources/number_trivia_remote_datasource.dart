import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
