import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetNumberTrivia extends Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository _numberTriviaRepository;

  GetNumberTrivia(this._numberTriviaRepository);

  Future<Either<AppError, NumberTrivia>> call(Params params) async {
    return await _numberTriviaRepository.getNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params(this.number);

  @override
  List<Object> get props => [number];
}
