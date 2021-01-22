import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDatasource _localDatasource;
  final NumberTriviaRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  NumberTriviaRepositoryImpl({
    @required NumberTriviaLocalDatasource localDatasource,
    @required NumberTriviaRemoteDatasource remoteDatasource,
    @required NetworkInfo networkInfo,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource,
        _networkInfo = networkInfo;

  @override
  Future<Either<AppError, NumberTrivia>> getNumberTrivia(int number) {
    // TODO: implement getNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
