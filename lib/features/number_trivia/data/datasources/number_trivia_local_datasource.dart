import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastCachedTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}
