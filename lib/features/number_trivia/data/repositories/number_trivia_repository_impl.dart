import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_number_trivia/core/errors/exceptions.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/network_info.dart';
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
  Future<Either<AppError, NumberTrivia>> getNumberTrivia(int number) async {
    return await _getNumberTriviaBy(
      () => _remoteDatasource.getNumberTrivia(number),
    );
  }

  @override
  Future<Either<AppError, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getNumberTriviaBy(
      () => _remoteDatasource.getRandomNumberTrivia(),
    );
  }

  Future<Either<AppError, NumberTrivia>> _getNumberTriviaBy(
    Future<NumberTriviaModel> Function() function,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final numberTriviaModel = await function();
        _localDatasource.cacheNumberTrivia(numberTriviaModel);
        return Right(numberTriviaModel);
      } on ServerException {
        return Left(ServerError());
      }
    } else {
      try {
        final cachedNumberTrivia = await _localDatasource.getLastCachedTrivia();
        return Right(cachedNumberTrivia);
      } on CacheException {
        return Left(CacheError());
      }
    }
  }
}
