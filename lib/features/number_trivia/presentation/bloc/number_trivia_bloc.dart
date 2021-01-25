import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_number_trivia/core/errors/errors.dart';
import 'package:flutter_number_trivia/core/usecases/usecase.dart';
import 'package:flutter_number_trivia/core/utils/input_converter.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const NUMBER_TRIVIA_INPUT_ERROR_MESSAGE =
    'Invalid input - please enter a positive integer';

const NUMBER_TRIVIA_CACHE_ERROR_MESSAGE = 'No connection and no saved results';

const NUMBER_TRIVIA_SERVER_ERROR_MESSAGE =
    'Somethin went wrong with the server';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetNumberTrivia _getNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  NumberTriviaBloc({
    @required GetNumberTrivia getNumberTrivia,
    @required GetRandomNumberTrivia getRandomNumberTrivia,
    @required InputConverter inputConverter,
  })  : _getNumberTrivia = getNumberTrivia,
        _getRandomNumberTrivia = getRandomNumberTrivia,
        _inputConverter = inputConverter,
        super(NumberTriviaInitial());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetNumberTriviaEvent) {
      yield NumberTriviaLoading();
      final eitherNumber =
          _inputConverter.stringToPositiveInteger(event.numberString);

      yield* eitherNumber.fold(
        (l) async* {
          yield NumberTriviaError(NUMBER_TRIVIA_INPUT_ERROR_MESSAGE);
        },
        (number) async* {
          final eitherTrivia = await _getNumberTrivia(Params(number));
          yield* foldEitherTriviaOrError(eitherTrivia);
        },
      );
    }

    if (event is GetRandomNumberTriviaEvent) {
      yield NumberTriviaLoading();
      final eitherTrivia = await _getRandomNumberTrivia(NoParams());
      yield* foldEitherTriviaOrError(eitherTrivia);
    }
  }

  Stream<NumberTriviaState> foldEitherTriviaOrError(
    Either<AppError, NumberTrivia> eitherTrivia,
  ) async* {
    yield* eitherTrivia.fold(
      (l) async* {
        yield NumberTriviaError(_mapErrorToMessage(l));
      },
      (r) async* {
        yield NumberTriviaLoaded(r);
      },
    );
  }

  String _mapErrorToMessage(AppError error) {
    switch (error.runtimeType) {
      case ServerError:
        return NUMBER_TRIVIA_SERVER_ERROR_MESSAGE;
      case CacheError:
        return NUMBER_TRIVIA_CACHE_ERROR_MESSAGE;
      default:
        throw UnimplementedError();
    }
  }
}
