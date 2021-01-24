import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DataConnectionChekerMock extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  DataConnectionChecker connectionChecker;

  setUp(() {
    connectionChecker = DataConnectionChekerMock();
    networkInfo = NetworkInfoImpl(connectionChecker);
  });

  group('isConnected', () {
    test('should foward connectionChecker is connected', () async {
      final tIsConnectedFuture = Future.value(true);

      when(connectionChecker.hasConnection)
          .thenAnswer((_) => tIsConnectedFuture);

      final result = networkInfo.isConnected;

      expect(result, tIsConnectedFuture);
    });
  });
}
