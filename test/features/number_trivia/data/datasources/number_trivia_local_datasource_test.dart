import 'package:flutter_number_trivia/core/errors/exceptions.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDatasource localDatasource;
  SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = SharedPreferencesMock();
    localDatasource = NumberTriviaLocalDatasourceSharedPref(sharedPreferences);
  });

  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');

  group('cacheNumberTrivia', () {
    test('should cache the passed numberTrivia', () async {
      when(sharedPreferences.setString(any, any)).thenAnswer((_) async => null);

      await localDatasource.cacheNumberTrivia(tNumberTriviaModel);

      verify(sharedPreferences.setString(any, tNumberTriviaModel.toJson()));
    });
  });

  group('getLastCachedTrivia', () {
    test('should return last cached numberTrivia if exists', () async {
      when(sharedPreferences.getString(any))
          .thenReturn(tNumberTriviaModel.toJson());

      final numberTrivia = await localDatasource.getLastCachedTrivia();

      expect(numberTrivia, tNumberTriviaModel);
      verify(sharedPreferences.getString(any));
    });

    test('should throw CacheException if cached numberTrivia is empty',
        () async {
      when(sharedPreferences.getString(any)).thenReturn(null);

      final getNumberTrivia = localDatasource.getLastCachedTrivia;

      expect(getNumberTrivia, throwsA(isA<CacheException>()));
    });
  });
}
