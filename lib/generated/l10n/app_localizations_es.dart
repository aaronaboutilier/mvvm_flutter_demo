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
  String get homeTitle => 'Demo MVVM - Inicio';

  @override
  String get detailsTitle => 'Demo MVVM - Detalles';

  @override
  String welcomeBack(String userName) {
    return '¡Bienvenido de vuelta, $userName!';
  }

  @override
  String get welcomeGuest => '¡Bienvenido, Invitado!';

  @override
  String get loadingUser => 'Cargando información del usuario...';

  @override
  String get userInformation => 'Información del Usuario:';

  @override
  String userId(String id) {
    return 'ID: $id';
  }

  @override
  String userName(String name) {
    return 'Nombre: $name';
  }

  @override
  String userEmail(String email) {
    return 'Correo: $email';
  }

  @override
  String buttonClickedTimes(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Botón presionado $countString veces';
  }

  @override
  String get clickMe => '¡Presióname!';

  @override
  String get navigationExample => 'Ejemplo de Navegación';

  @override
  String get goToDetails => 'Ir a Detalles';

  @override
  String get backToHome => 'Volver al Inicio';

  @override
  String get chooseThemeColor => 'Elige tu Color de Tema:';

  @override
  String get addNewItem => 'Agregar Nuevo Elemento:';

  @override
  String get enterItemName => 'Ingresa el nombre del elemento...';

  @override
  String yourItems(int count) {
    return 'Tus Elementos ($count):';
  }

  @override
  String get noItemsYet => 'Aún no hay elementos';

  @override
  String get addFirstItem => '¡Agrega tu primer elemento arriba para comenzar!';

  @override
  String itemsSummary(int count, String color) {
    return 'Tienes $count elementos en tema $color';
  }

  @override
  String get noItemsSummary =>
      'Aún no hay elementos. ¡Agrega algunos para comenzar!';

  @override
  String get clearAllItems => 'Limpiar Todos los Elementos';

  @override
  String get clearAllConfirmation =>
      '¿Estás seguro de que quieres eliminar todos los elementos?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clearAll => 'Limpiar Todo';

  @override
  String get retry => 'Reintentar';

  @override
  String get clearUser => 'Limpiar Usuario';

  @override
  String get navigation => 'Navegación';

  @override
  String get pageNotFound => 'Página No Encontrada';

  @override
  String get pageNotFoundMessage => '¡Ups! Página no encontrada.';

  @override
  String get goHome => 'Ir al Inicio';

  @override
  String get colorRed => 'Rojo';

  @override
  String get colorBlue => 'Azul';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorYellow => 'Amarillo';

  @override
  String get colorPurple => 'Morado';

  @override
  String get colorOrange => 'Naranja';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get themeSettings => 'Tema y Apariencia';

  @override
  String get themeMode => 'Modo de Tema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get textSize => 'Tamaño de Texto';

  @override
  String get textSizeSmall => 'A';

  @override
  String get textSizeLarge => 'A';

  @override
  String get accessibilitySettings => 'Accesibilidad';

  @override
  String get reduceAnimations => 'Reducir Animaciones';

  @override
  String get reduceAnimationsDescription =>
      'Minimizar movimiento para mejor accesibilidad';

  @override
  String get highContrast => 'Alto Contraste';

  @override
  String get highContrastDescription =>
      'Aumentar contraste para mejor visibilidad';

  @override
  String get largerTouchTargets => 'Objetivos Táctiles Más Grandes';

  @override
  String get largerTouchTargetsDescription =>
      'Hacer botones y controles más fáciles de tocar';

  @override
  String get voiceGuidance => 'Guía de Voz';

  @override
  String get voiceGuidanceDescription =>
      'Activar texto a voz para elementos de interfaz';

  @override
  String get hapticFeedback => 'Retroalimentación Háptica';

  @override
  String get hapticFeedbackDescription =>
      'Sentir vibraciones al interactuar con la aplicación';

  @override
  String get languageSettings => 'Idioma y Región';

  @override
  String get useDeviceLanguage => 'Usar Idioma del Dispositivo';

  @override
  String get useDeviceLanguageDescription =>
      'Seguir la configuración de idioma de tu dispositivo';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get language => 'Idioma';

  @override
  String get advancedSettings => 'Avanzado';

  @override
  String get exportSettings => 'Exportar Configuración';

  @override
  String get exportSettingsDescription =>
      'Guardar tu configuración actual en un archivo';

  @override
  String get resetToDefaults => 'Restablecer Valores Predeterminados';

  @override
  String get resetToDefaultsDescription =>
      'Restaurar toda la configuración a sus valores originales';

  @override
  String get resetConfirmation =>
      'Esto restablecerá todas tus preferencias a los valores predeterminados. Esta acción no se puede deshacer.';

  @override
  String get reset => 'Restablecer';

  @override
  String get aboutApp => 'Acerca de';

  @override
  String get appName => 'Nombre de la Aplicación';

  @override
  String get version => 'Versión';

  @override
  String get website => 'Sitio Web';

  @override
  String get support => 'Soporte';
}
