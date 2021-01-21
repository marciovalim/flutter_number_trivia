import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository _numberTriviaRepository;

  GetRandomNumberTrivia(this._numberTriviaRepository);

  @override
  Future<Either<AppError, NumberTrivia>> call(NoParams params) async {
    return await _numberTriviaRepository.getRandomNumberTrivia();
  }
}
