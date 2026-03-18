import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/form/data/repositories/form_repository.dart';
import '../../features/form/manager/form_cubit.dart';

final sl = GetIt.instance; // sl stands for Service Locator

void setupServiceLocator() {
  // External
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Repository
  sl.registerLazySingleton<FormRepository>(
    () => FormRepository(sl()),
  );

  // Cubit (Factory so a new instance is created each time we need one for a fresh form, 
  // or LazySingleton if you want it to persist across the app lifecycle. We'll use Factory here.)
  sl.registerFactory<FormCubit>(
    () => FormCubit(sl()),
  );
}
