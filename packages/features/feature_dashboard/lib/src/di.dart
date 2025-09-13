import 'package:feature_dashboard/src/application/usecases/clear_user.dart';
import 'package:feature_dashboard/src/application/usecases/load_user.dart';
import 'package:feature_dashboard/src/domain/repositories/user_repository.dart';
import 'package:feature_dashboard/src/infrastructure/repositories/in_memory_user_repository.dart';
import 'package:feature_dashboard/src/presentation/viewmodels/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// Registers Dashboard feature dependencies into the provided GetIt locator.
/// Keep feature wiring self-contained; the app calls this during startup.
void registerFeatureDashboard(GetIt locator) {
  // Repository
  locator
    ..registerLazySingleton<UserRepository>(
      () => InMemoryUserRepository(locator()),
    )
    // Use cases
    ..registerFactory(() => LoadUser(locator()))
    ..registerFactory(() => ClearUser(locator()))
    // ViewModel
    ..registerFactory<HomeViewModel>(
      () => HomeViewModel(loadUser: locator(), clearUser: locator()),
    );
}
