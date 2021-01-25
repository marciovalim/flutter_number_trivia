import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NumberTriviaRepositoryMock extends Mock
    implements NumberTriviaRepository {}

void main() {
  NumberTriviaRepositoryMock repositoryMock;
  GetNumberTrivia getNumberTrivia;

  setUp(() {
    repositoryMock = NumberTriviaRepositoryMock();
    getNumberTrivia = GetNumberTrivia(repositoryMock);
  });

  final tNumber = 10;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: 'text for test');

  test(
    'when called to get number trivia, should return number trivia',
    () async {
      when(repositoryMock.getNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      final result = await getNumberTrivia(GetNumberTriviaParams(tNumber));

      expect(result, Right(tNumberTrivia));
      verify(repositoryMock.getNumberTrivia(tNumber));
      verifyNoMoreInteractions(repositoryMock);
    },
  );
}
