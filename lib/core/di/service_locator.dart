import 'package:get_it/get_it.dart';
import '../../data/datasources/item_local_datasource.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../domain/repositories/item_repository.dart';
import '../../presentation/bloc/item_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {

  // datasource
  getIt.registerLazySingleton<ItemLocalDatasource>(
        () => ItemLocalDatasource(),
  );

  // repository
  getIt.registerLazySingleton<ItemRepository>(
        () => ItemRepositoryImpl(getIt()),
  );

  // bloc
  getIt.registerFactory<ItemBloc>(
        () => ItemBloc(getIt()),
  );

}