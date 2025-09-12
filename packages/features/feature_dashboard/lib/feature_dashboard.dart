// Barrel export to expose the package API surface.
// Domain
export 'src/domain/entities/user.dart';
export 'src/domain/repositories/user_repository.dart';
// Application
export 'src/application/usecases/load_user.dart';
export 'src/application/usecases/clear_user.dart';
// Presentation and routes API
export 'src/presentation/dashboard_page.dart';
export 'src/presentation/viewmodels/home_view_state.dart';
export 'src/presentation/viewmodels/home_viewmodel.dart';
export 'src/routes.dart' show featureDashboardRoutes, DashboardRoutes, DashboardRouteHelper;
// Export DI registration hook for the feature
export 'src/di.dart' show registerFeatureDashboard;
