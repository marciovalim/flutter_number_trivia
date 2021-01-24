import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerError extends AppError {}

class CacheError extends AppError {}
