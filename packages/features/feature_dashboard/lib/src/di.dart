import 'package:get_it/get_it.dart';

import 'application/usecases/clear_user.dart';
import 'application/usecases/load_user.dart';
import 'domain/repositories/user_repository.dart';
import 'infrastructure/repositories/in_memory_user_repository.dart';
import 'presentation/viewmodels/home_viewmodel.dart';

/// Registers Dashboard feature dependencies into the provided GetIt locator.
/// Keep feature wiring self-contained; the app calls this during startup.
void registerFeatureDashboard(GetIt locator) {
  // Repository
  locator.registerLazySingleton<UserRepository>(
    () => InMemoryUserRepository(locator()),
  );

  // Use cases
  locator.registerFactory(() => LoadUser(locator()));
  locator.registerFactory(() => ClearUser(locator()));

  // ViewModel
  locator.registerFactory<HomeViewModel>(
    () => HomeViewModel(loadUser: locator(), clearUser: locator()),
  );
}
