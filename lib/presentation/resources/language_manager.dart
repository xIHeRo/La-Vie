// ignore_for_file: constant_identifier_names

enum LanguageType { ENGLISH, ARABIC }

const String ENGLISH = "eg";
const String ARABIC = "ar";

extension LanguageTypeExtention on LanguageType {
  String getLanguage() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;

      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}
