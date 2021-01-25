import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia/core/utils/input_converter.dart';
import 'package:flutter_number_trivia/core/utils/network_info.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Di {
  const Di._();

  static Future<void> setup() async {
    await _setupExternal();
    await _setupCore();
    await _setupNumberTrivia();
  }

  static Future<void> _setupNumberTrivia() async {
    //! Blocs
    getIt.registerFactory<NumberTriviaBloc>(
      () => NumberTriviaBloc(
        getNumberTrivia: getIt(),
        inputConverter: getIt(),
        getRandomNumberTrivia: getIt(),
      ),
    );

    //! Usecases
    getIt.registerLazySingleton<GetNumberTrivia>(
      () => GetNumberTrivia(getIt()),
    );
    getIt.registerLazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(getIt()),
    );

    //! Repositories
    getIt.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
        localDatasource: getIt(),
        remoteDatasource: getIt(),
        networkInfo: getIt(),
      ),
    );

    //! Datasources
    getIt.registerLazySingleton<NumberTriviaLocalDatasource>(
      () => NumberTriviaLocalDatasourceSharedPref(getIt()),
    );
    getIt.registerLazySingleton<NumberTriviaRemoteDatasource>(
      () => NumberTriviaRemoteDatasourceHttp(getIt()),
    );
  }

  static Future<void> _setupCore() async {
    getIt.registerLazySingleton<InputConverter>(() => InputConverter());
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  }

  static Future<void> _setupExternal() async {
    getIt.registerLazySingleton<Client>(() => Client());

    getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker(),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }
}
