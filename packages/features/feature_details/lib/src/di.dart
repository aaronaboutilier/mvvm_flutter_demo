import 'package:feature_details/src/application/usecases/add_detail_item.dart';
import 'package:feature_details/src/application/usecases/clear_detail_items.dart';
import 'package:feature_details/src/application/usecases/get_detail_items.dart';
import 'package:feature_details/src/application/usecases/remove_detail_item.dart';
import 'package:feature_details/src/application/usecases/reorder_detail_items.dart';
import 'package:feature_details/src/domain/repositories/details_repository.dart';
import 'package:feature_details/src/infrastructure/repositories/in_memory_details_repository.dart';
import 'package:feature_details/src/presentation/viewmodels/details_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// Registers Details feature dependencies into the provided GetIt locator.
/// Keep feature wiring self-contained; the app calls this during startup.
void registerFeatureDetails(GetIt locator) {
  // Repository
  locator
    ..registerLazySingleton<DetailsRepository>(
      () => InMemoryDetailsRepository(locator()),
    )
    // Use cases
    ..registerFactory(() => GetDetailItems(locator()))
    ..registerFactory(() => AddDetailItem(locator()))
    ..registerFactory(() => RemoveDetailItem(locator()))
    ..registerFactory(() => ClearDetailItems(locator()))
    ..registerFactory(() => ReorderDetailItems(locator()))
    // ViewModel
    ..registerFactory<DetailsViewModel>(
      () => DetailsViewModel(
        getItems: locator(),
        addItem: locator(),
        removeItem: locator(),
        clearItems: locator(),
        reorderItems: locator(),
      ),
    );
}
