import 'package:get_it/get_it.dart';
import 'application/usecases/add_detail_item.dart';
import 'application/usecases/clear_detail_items.dart';
import 'application/usecases/get_detail_items.dart';
import 'application/usecases/remove_detail_item.dart';
import 'application/usecases/reorder_detail_items.dart';
import 'domain/repositories/details_repository.dart';
import 'infrastructure/repositories/in_memory_details_repository.dart';
import 'presentation/viewmodels/details_viewmodel.dart';

/// Registers Details feature dependencies into the provided GetIt locator.
/// Keep feature wiring self-contained; the app calls this during startup.
void registerFeatureDetails(GetIt locator) {
  // Repository
  locator.registerLazySingleton<DetailsRepository>(
    () => InMemoryDetailsRepository(locator()),
  );

  // Use cases
  locator.registerFactory(() => GetDetailItems(locator()));
  locator.registerFactory(() => AddDetailItem(locator()));
  locator.registerFactory(() => RemoveDetailItem(locator()));
  locator.registerFactory(() => ClearDetailItems(locator()));
  locator.registerFactory(() => ReorderDetailItems(locator()));

  // ViewModel
  locator.registerFactory<DetailsViewModel>(() => DetailsViewModel(
        getItems: locator(),
        addItem: locator(),
        removeItem: locator(),
        clearItems: locator(),
        reorderItems: locator(),
      ));
}
