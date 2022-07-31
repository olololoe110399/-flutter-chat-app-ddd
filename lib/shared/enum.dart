enum DeviceType { mobile, tablet }

enum LanguageCode {
  en,
  ja,
  vi,
}

enum Popup { normal }

extension LanguageCodeExt on LanguageCode {
  String get locale {
    switch (this) {
      case LanguageCode.en:
        return 'en';
      case LanguageCode.vi:
        return 'vi';
      case LanguageCode.ja:
        return 'ja';
      default:
        return 'en';
    }
  }
}
