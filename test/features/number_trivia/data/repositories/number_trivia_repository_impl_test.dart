import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia/core/errors/errors.dart';
import 'package:flutter_number_trivia/core/errors/exceptions.dart';
import 'package:flutter_number_trivia/core/utils/network_info.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRemoteDatasource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockNumberTriviaLocalDatasource extends Mock
    implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaLocalDatasource localDatasource;
  NumberTriviaRemoteDatasource remoteDatasource;
  NetworkInfo networkInfo;
  NumberTriviaRepository repository;

  setUp(() {
    localDatasource = MockNumberTriviaLocalDatasource();
    remoteDatasource = MockNumberTriviaRemoteDatasource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      localDatasource: localDatasource,
      remoteDatasource: remoteDatasource,
      networkInfo: networkInfo,
    );
  });

  void runOnline(Function body) {
    group('when online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOffline(Function body) {
    group('when offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  final tNumber = 1;
  final tNumberTriviaModel = NumberTriviaModel(
    number: tNumber,
    text: 'test text',
  );

  group('getNumberTrivia', () {
    test('should check if is connected', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      await repository.getNumberTrivia(tNumber);

      verify(networkInfo.isConnected);
    });

    runOnline(() {
      test('should return NumberTrivia if server request is successful',
          () async {
        when(remoteDatasource.getNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getNumberTrivia(tNumber);

        expect(result, equals(Right(tNumberTriviaModel)));
      });

      test('should cache result if server request is successful', () async {
        when(remoteDatasource.getNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        await repository.getNumberTrivia(tNumber);

        verify(localDatasource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test('should return ServerError if server request is unsuccessful',
          () async {
        when(remoteDatasource.getNumberTrivia(any))
            .thenThrow(ServerException());

        final result = await repository.getNumberTrivia(tNumber);

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<ServerError>());
      });
    });

    runOffline(() {
      test('should return NumberTrivia if has cached data', () async {
        when(localDatasource.getLastCachedTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getNumberTrivia(tNumber);

        expect(result, equals(Right(tNumberTriviaModel)));
      });

      test('should return CacheError if cached data is empty', () async {
        when(localDatasource.getLastCachedTrivia()).thenThrow(CacheException());

        final result = await repository.getNumberTrivia(tNumber);

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<CacheError>());
      });
    });
  });

  group('getRandomNumberTrivia', () {
    test('should check if is connected', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      await repository.getRandomNumberTrivia();

      verify(networkInfo.isConnected);
    });

    runOnline(() {
      test('should return NumberTrivia if server request is successful',
          () async {
        when(remoteDatasource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getRandomNumberTrivia();

        expect(result, equals(Right(tNumberTriviaModel)));
      });

      test('should cache result if server request is successful', () async {
        when(remoteDatasource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        await repository.getRandomNumberTrivia();

        verify(localDatasource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test('should return ServerError if server request is unsuccessful',
          () async {
        when(remoteDatasource.getRandomNumberTrivia())
            .thenThrow(ServerException());

        final result = await repository.getRandomNumberTrivia();

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<ServerError>());
      });
    });

    runOffline(() {
      test('should return NumberTrivia if has cached data', () async {
        when(localDatasource.getLastCachedTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getRandomNumberTrivia();

        expect(result, equals(Right(tNumberTriviaModel)));
      });

      test('should return CacheError if cached data is empty', () async {
        when(localDatasource.getLastCachedTrivia()).thenThrow(CacheException());

        final result = await repository.getRandomNumberTrivia();

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<CacheError>());
      });
    });
  });
}
