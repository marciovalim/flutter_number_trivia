import 'package:flutter_number_trivia/core/platform/network_info.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRemoteDatasource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockNumberTriviaLocalDatasource extends Mock
    implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaLocalDatasource localDatasource;
  NumberTriviaRemoteDatasource remoteDatasource;
  NetworkInfo networkInfo;
  NumberTriviaRepository numberTriviaRepository;

  setUp(() {
    localDatasource = MockNumberTriviaLocalDatasource();
    remoteDatasource = MockNumberTriviaRemoteDatasource();
    networkInfo = MockNetworkInfo();
    numberTriviaRepository = NumberTriviaRepositoryImpl(
      localDatasource: localDatasource,
      remoteDatasource: remoteDatasource,
      networkInfo: networkInfo,
    );
  });
}
