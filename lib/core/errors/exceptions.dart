import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;

  AppException(this.message);

  @override
  List<Object> get props => [message];
}

class ServerException extends AppException {
  ServerException({String message}) : super(message);
}

class CacheException extends AppException {
  CacheException({String message}) : super(message);
}
