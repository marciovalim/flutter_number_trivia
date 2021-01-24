import 'package:flutter_number_trivia/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastCachedTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}

class NumberTriviaLocalDatasourceSharedPref
    implements NumberTriviaLocalDatasource {
  static const _cachedNumberTriviaKey = 'cacheNumberTriviaKey';

  final SharedPreferences _sharedPreferences;

  NumberTriviaLocalDatasourceSharedPref(this._sharedPreferences);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel) async {
    final triviaInJson = triviaModel.toJson();
    await _sharedPreferences.setString(_cachedNumberTriviaKey, triviaInJson);
  }

  @override
  Future<NumberTriviaModel> getLastCachedTrivia() async {
    final triviaInJson = _sharedPreferences.getString(_cachedNumberTriviaKey);

    if (triviaInJson != null) {
      return NumberTriviaModel.fromJson(triviaInJson);
    }
    throw CacheException();
  }
}
