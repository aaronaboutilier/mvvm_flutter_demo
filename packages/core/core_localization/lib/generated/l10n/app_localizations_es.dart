// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Demo MVVM';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get backToHome => 'Volver al Inicio';

  @override
  String get close => 'Cerrar';

  @override
  String get theme => 'Tema';

  @override
  String get themeMode => 'Modo de Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get textSize => 'Tamaño de Texto';

  @override
  String get small => 'Pequeño';

  @override
  String get large => 'Grande';

  @override
  String get accessibility => 'Accesibilidad';

  @override
  String get reduceAnimations => 'Reducir Animaciones';

  @override
  String get highContrast => 'Alto Contraste';

  @override
  String get largerTouchTargets => 'Objetivos Táctiles Más Grandes';

  @override
  String get voiceGuidance => 'Guía de Voz';

  @override
  String get hapticFeedback => 'Retroalimentación Háptica';

  @override
  String get language => 'Idioma';

  @override
  String get useDeviceLanguage => 'Usar Idioma del Dispositivo';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get exportConfiguration => 'Exportar Configuración';

  @override
  String get resetToDefaults => 'Restablecer Valores Predeterminados';

  @override
  String get advanced => 'Avanzado';

  @override
  String get dashboard => 'Tablero';

  @override
  String get products => 'Productos';

  @override
  String get detailsTitle => 'Demo MVVM - Detalles';

  @override
  String get retry => 'Reintentar';

  @override
  String get clickMe => '¡Presióname!';

  @override
  String get goToDetails => 'Ir a Detalles';

  @override
  String get openSettings => 'Abrir Configuración';

  @override
  String get navigation => 'Navegación';

  @override
  String get navigationExample => 'Ejemplo de Navegación';

  @override
  String get loadingUserInformation => 'Cargando información del usuario...';

  @override
  String get userInformation => 'Información del Usuario:';

  @override
  String get clearUser => 'Borrar Usuario';

  @override
  String buttonClickedTimes(Object count) {
    return 'Botón presionado $count veces';
  }

  @override
  String get chooseThemeColor => 'Elige tu color de tema:';

  @override
  String get addNewItem => 'Agregar nuevo elemento:';

  @override
  String get enterItemNameHint => 'Ingresa el nombre del elemento...';

  @override
  String get noItemsYet => 'Aún no hay elementos';

  @override
  String get addFirstItemHelp =>
      '¡Agrega tu primer elemento arriba para comenzar!';

  @override
  String itemsCount(Object count) {
    return 'Elementos: $count';
  }

  @override
  String yourItemsCount(Object count) {
    return 'Tus elementos ($count):';
  }

  @override
  String get clearAllItems => 'Limpiar Todos los Elementos';

  @override
  String get clearAllConfirmation =>
      '¿Estás seguro de que quieres eliminar todos los elementos?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clearAll => 'Limpiar Todo';
}
