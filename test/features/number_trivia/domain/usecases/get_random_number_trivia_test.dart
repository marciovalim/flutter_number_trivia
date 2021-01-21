import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia/core/usecases/usecase.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NumberTriviaRepositoryMock extends Mock
    implements NumberTriviaRepository {}

void main() {
  NumberTriviaRepositoryMock repositoryMock;
  GetRandomNumberTrivia getRandomNumberTrivia;

  setUp(() {
    repositoryMock = NumberTriviaRepositoryMock();
    getRandomNumberTrivia = GetRandomNumberTrivia(repositoryMock);
  });

  final tNumberTrivia = NumberTrivia(number: 10, text: 'text for test');

  test(
    'when called to get random number trivia, should return random number trivia',
    () async {
      when(repositoryMock.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));

      final result = await getRandomNumberTrivia(NoParams());

      expect(result, Right(tNumberTrivia));
      verify(repositoryMock.getRandomNumberTrivia());
      verifyNoMoreInteractions(repositoryMock);
    },
  );
}
