class AppConfig {
  String _streamKey = '';

  static final AppConfig _singleton = AppConfig();

  static AppConfig get instance => _singleton;

  String get streamKey => _streamKey;

  void init() {
    _streamKey = const String.fromEnvironment('STREAM_KEY', defaultValue: '');
  }
}
