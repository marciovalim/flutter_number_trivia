import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia/core/errors/errors.dart';
import 'package:flutter_number_trivia/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToPositiveInteger', () {
    test('should return an integer when string is positive integer', () {
      final string = "123";

      final result = inputConverter.stringToPositiveInteger(string);

      expect(result, Right(123));
    });

    test('should throw an InvalidFormatError when string is not an integer',
        () {
      final string = "12efd";

      final result = inputConverter.stringToPositiveInteger(string);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidFormatError>());
    });

    test('should throw an InvalidFormatError when string is a negative integer',
        () {
      final string = "-243";

      final result = inputConverter.stringToPositiveInteger(string);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidFormatError>());
    });
  });
}
