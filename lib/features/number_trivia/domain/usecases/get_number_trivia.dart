import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetNumberTrivia extends Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetNumberTrivia(this.numberTriviaRepository);

  Future<Either<AppError, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepository.getNumberTrivia(params.number);
  }
}

class Params {
  final int number;

  Params(this.number);
}
