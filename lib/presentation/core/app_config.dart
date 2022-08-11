class AppConfig {
  static final AppConfig _singleton = AppConfig();

  static AppConfig get instance => _singleton;

  String get streamKey => const String.fromEnvironment('STREAM_KEY', defaultValue: '');
}
