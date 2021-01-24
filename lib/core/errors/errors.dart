import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  final String message;

  AppError(this.message);

  @override
  List<Object> get props => [message];
}

class ServerError extends AppError {
  ServerError({String message}) : super(message);
}

class CacheError extends AppError {
  CacheError({String message}) : super(message);
}

class InvalidFormatError extends AppError {
  InvalidFormatError({String message}) : super(message);
}
