import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'core/util/input_validation.dart';
import 'features/quiz/data/datasources/question_remote_data_source.dart';
import 'features/quiz/data/repositories/question_repository_impl.dart';
import 'features/quiz/domain/repositories/question_repository.dart';
import 'features/quiz/domain/usecases/get_questions.dart';
import 'features/welcome/presentation/bloc/welcome_bloc.dart';

final sl = GetIt.instance; //sl (localizador de servicios).

Future<void> init() async {
  //! Features - Number Trivia
  //Bloc
  sl.registerFactory(
    () => WelcomeBloc(
      inputValidation: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetQuestions(sl()));
  // Repository
  sl.registerLazySingleton<QuestionRepository>(
    () => QuestionRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<QuestionRemoteDataSource>(
    () => QuestionRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InputValidation());

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}