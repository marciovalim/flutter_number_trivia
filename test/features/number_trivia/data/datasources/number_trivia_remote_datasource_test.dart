import 'package:flutter_number_trivia/core/errors/exceptions.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HttpClientMock extends Mock implements Client {}

void main() {
  Client httpClient;
  NumberTriviaRemoteDatasourceHttp remoteDatasource;

  setUp(() {
    httpClient = HttpClientMock();
    remoteDatasource = NumberTriviaRemoteDatasourceHttp(httpClient);
  });

  final tNumber = 1;
  final tNumberTriviaModel =
      NumberTriviaModel(number: tNumber, text: 'test text');
  final tApiResponse = tNumberTriviaModel.toJson();

  void setupUnsuccessfullRequest() {
    when(httpClient.get(any))
        .thenAnswer((_) async => Response('Something went wrong', 400));
  }

  void setupSuccessfullRequest() {
    when(httpClient.get(any))
        .thenAnswer((_) async => Response(tApiResponse, 200));
  }

  group('getNumberTrivia', () {
    test('should make a GET request when called', () async {
      setupSuccessfullRequest();

      await remoteDatasource.getNumberTrivia(tNumber);

      verify(httpClient.get(any));
    });

    test('should return numberTriviaModel when status code is 200', () async {
      setupSuccessfullRequest();

      final numberTrivia = await remoteDatasource.getNumberTrivia(tNumber);

      expect(numberTrivia, tNumberTriviaModel);
    });

    test('should throw a ServerException when status code is 400', () async {
      setupUnsuccessfullRequest();

      final getNumberTrivia = remoteDatasource.getNumberTrivia;

      expect(() => getNumberTrivia(tNumber), throwsA(isA<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    test('should make a GET request when called', () async {
      setupSuccessfullRequest();

      await remoteDatasource.getRandomNumberTrivia();

      verify(httpClient.get(any));
    });

    test('should return numberTriviaModel when status code is 200', () async {
      setupSuccessfullRequest();

      final numberTrivia = await remoteDatasource.getRandomNumberTrivia();

      expect(numberTrivia, tNumberTriviaModel);
    });

    test('should throw a ServerException when status code is 400', () async {
      setupUnsuccessfullRequest();

      final getRandomNumberTrivia = remoteDatasource.getRandomNumberTrivia;

      expect(getRandomNumberTrivia, throwsA(isA<ServerException>()));
    });
  });
}
