import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<AppError, NumberTrivia>> getNumberTrivia(int number);
  Future<Either<AppError, NumberTrivia>> getRandomNumberTrivia();
}
