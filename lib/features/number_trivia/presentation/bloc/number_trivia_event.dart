part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  GetNumberTriviaEvent(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}
