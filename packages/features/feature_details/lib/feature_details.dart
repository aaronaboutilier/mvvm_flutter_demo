// Public API for the Details feature
export 'src/application/usecases/add_detail_item.dart';
export 'src/application/usecases/clear_detail_items.dart';
export 'src/application/usecases/get_detail_items.dart';
export 'src/application/usecases/remove_detail_item.dart';
export 'src/application/usecases/reorder_detail_items.dart';
export 'src/di.dart' show registerFeatureDetails;
export 'src/domain/entities/detail_item.dart';
export 'src/domain/repositories/details_repository.dart';
export 'src/infrastructure/repositories/in_memory_details_repository.dart';
export 'src/presentation/viewmodels/details_view_state.dart';
export 'src/presentation/viewmodels/details_viewmodel.dart';
export 'src/presentation/views/details_page.dart';
export 'src/routes.dart'
    show DetailsRouteHelper, DetailsRoutes, featureDetailsRoutes;
