import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia/core/errors/errors.dart';

class InputConverter {
  Either<AppError, int> stringToPositiveInteger(String string) {
    try {
      final integer = int.parse(string);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidFormatError());
    }
  }
}
