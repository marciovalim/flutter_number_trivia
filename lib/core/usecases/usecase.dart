import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/app_error.dart';

abstract class Usecase<Output, Params> {
  Future<Either<AppError, Output>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
