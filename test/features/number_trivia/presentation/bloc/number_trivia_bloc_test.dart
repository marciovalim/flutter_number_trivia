import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia/core/errors/errors.dart';
import 'package:flutter_number_trivia/core/usecases/usecase.dart';
import 'package:flutter_number_trivia/core/utils/input_converter.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class GetNumberTriviaMock extends Mock implements GetNumberTrivia {}

class GetRandomNumberTriviaMock extends Mock implements GetRandomNumberTrivia {}

class InputConverterMock extends Mock implements InputConverter {}

void main() {
  GetNumberTrivia getNumberTrivia;
  GetRandomNumberTrivia getRandomNumberTrivia;
  InputConverter inputConverter;
  // ignore: close_sinks
  NumberTriviaBloc bloc;

  setUp(() {
    getNumberTrivia = GetNumberTriviaMock();
    getRandomNumberTrivia = GetRandomNumberTriviaMock();
    inputConverter = InputConverterMock();
    bloc = NumberTriviaBloc(
      getNumberTrivia: getNumberTrivia,
      getRandomNumberTrivia: getRandomNumberTrivia,
      inputConverter: inputConverter,
    );
  });

  group('GetNumberTriviaEvent', () {
    final tNumberString = '1';
    final tNumber = 1;
    final tNumberTrivia = NumberTrivia(number: tNumber, text: 'test text');

    void setupRightConversion() {
      when(inputConverter.stringToPositiveInteger(any))
          .thenReturn(Right(tNumber));
    }

    void setupWrongConversion() {
      when(inputConverter.stringToPositiveInteger(any))
          .thenReturn(Left(InvalidFormatError()));
    }

    void addGetNumberTriviaEvent() {
      bloc.add(GetNumberTriviaEvent(tNumberString));
    }

    test('should call input converter', () async {
      when(getNumberTrivia(any)).thenAnswer((_) async => Left(ServerError()));
      setupRightConversion();

      addGetNumberTriviaEvent();

      await untilCalled(inputConverter.stringToPositiveInteger(any));

      verify(inputConverter.stringToPositiveInteger(tNumberString));
    });

    test('should emit error with invalid input message if bad input', () {
      setupWrongConversion();

      addGetNumberTriviaEvent();

      final expectedEmits = [
        NumberTriviaLoading(),
        NumberTriviaError(NUMBER_TRIVIA_INPUT_ERROR_MESSAGE),
      ];
      expectLater(bloc.cast(), emitsInOrder(expectedEmits));
    });

    group('good input', () {
      setUp(setupRightConversion);

      test('should call getNumberTrivia', () async {
        when(getNumberTrivia(any)).thenAnswer((_) async => Left(ServerError()));

        addGetNumberTriviaEvent();
        await untilCalled(getNumberTrivia(any));

        verify(getNumberTrivia(Params(tNumber)));
      });

      test('should emit error with server_error message if server error', () {
        when(getNumberTrivia(any)).thenAnswer((_) async => Left(ServerError()));

        addGetNumberTriviaEvent();

        final expectedEmits = [
          NumberTriviaLoading(),
          NumberTriviaError(NUMBER_TRIVIA_SERVER_ERROR_MESSAGE),
        ];
        expectLater(bloc.cast(), emitsInOrder(expectedEmits));
      });

      test('should emit error with cache_error message if server error', () {
        when(getNumberTrivia(any)).thenAnswer((_) async => Left(CacheError()));

        addGetNumberTriviaEvent();

        final expectedEmits = [
          NumberTriviaLoading(),
          NumberTriviaError(NUMBER_TRIVIA_CACHE_ERROR_MESSAGE),
        ];
        expectLater(bloc.cast(), emitsInOrder(expectedEmits));
      });

      test('should emit loaded state if request is successful', () {
        when(getNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        addGetNumberTriviaEvent();

        final expectedEmits = [
          NumberTriviaLoading(),
          NumberTriviaLoaded(tNumberTrivia),
        ];
        expectLater(bloc.cast(), emitsInOrder(expectedEmits));
      });
    });
  });

  group('GetRandomNumberTriviaEvent', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test text');

    void addGetRandomNumberTriviaEvent() {
      bloc.add(GetRandomNumberTriviaEvent());
    }

    group('good input', () {
      test('should call getNumberTrivia', () async {
        when(getRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerError()));

        addGetRandomNumberTriviaEvent();
        await untilCalled(getRandomNumberTrivia(any));

        verify(getRandomNumberTrivia(NoParams()));
      });

      test('should emit error with server_error message if server error', () {
        when(getRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerError()));

        addGetRandomNumberTriviaEvent();

        final expectedEmits = [
          NumberTriviaLoading(),
          NumberTriviaError(NUMBER_TRIVIA_SERVER_ERROR_MESSAGE),
        ];
        expectLater(bloc.cast(), emitsInOrder(expectedEmits));
      });

      test('should emit error with cache_error message if server error', () {
        when(getRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheError()));

        addGetRandomNumberTriviaEvent();

        final expectedEmits = [
          NumberTriviaLoading(),
          NumberTriviaError(NUMBER_TRIVIA_CACHE_ERROR_MESSAGE),
        ];
        expectLater(bloc.cast(), emitsInOrder(expectedEmits));
      });

      test('should emit loaded state if request is successful', () {
        when(getRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        addGetRandomNumberTriviaEvent();

        final expectedEmits = [
          NumberTriviaLoading(),
          NumberTriviaLoaded(tNumberTrivia),
        ];
        expectLater(bloc.cast(), emitsInOrder(expectedEmits));
      });
    });
  });
}
