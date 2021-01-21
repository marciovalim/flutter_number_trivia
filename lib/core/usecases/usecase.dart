import 'package:dartz/dartz.dart';

import '../errors/app_error.dart';

abstract class Usecase<Output, Params> {
  Future<Either<AppError, Output>> call(Params params);
}
