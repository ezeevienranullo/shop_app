import 'package:get_it/get_it.dart';
import 'package:shop_app/presentation/bloc/session_bloc.dart';
import '../../data/datasources/item_local_datasource.dart';
import '../../data/datasources/session_local_datasource.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../domain/repositories/item_repository.dart';
import '../../domain/repositories/session_repository.dart';
import '../../presentation/bloc/item_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {

  // datasource
  getIt.registerLazySingleton<ItemLocalDatasource>(
        () => ItemLocalDatasource(),
  );

  getIt.registerLazySingleton<SessionLocalDatasource>(
        () => SessionLocalDatasource(),
  );

  // repository
  getIt.registerLazySingleton<ItemRepository>(
        () => ItemRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<SessionRepository>(
        () => SessionRepositoryImpl(getIt()),
  );

  // bloc
  getIt.registerFactory<ItemBloc>(
        () => ItemBloc(getIt()),
  );

  getIt.registerFactory<SessionBloc>(
        () => SessionBloc(getIt()),
  );

}