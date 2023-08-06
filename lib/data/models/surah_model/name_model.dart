import 'package:al_quran_apps/domain/entities/surah/name.dart';
import 'package:equatable/equatable.dart';

class NameModel extends Equatable {
  const NameModel({
    required this.short,
    required this.long,
    required this.transliteration,
    required this.translation,
  });

  final String? short;
  final String? long;
  final TransliterationModel? transliteration;
  final TranslationModel? translation;

  factory NameModel.fromJson(Map<String, dynamic>? json) => NameModel(
        short: json?["short"],
        long: json?["long"],
        transliteration:
            TransliterationModel.fromJson(json?["transliteration"]),
        translation: TranslationModel.fromJson(json?["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration?.toJson(),
        "translation": translation?.toJson(),
      };
  Name toEntity() {
    return Name(
      short: short,
      long: long,
      transliteration: transliteration!.toEntity(),
      translation: translation!.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        short,
        long,
        transliteration,
        translation,
      ];
}

class TranslationModel extends Equatable {
  const TranslationModel({
    required this.en,
    required this.id,
  });

  final String? en;
  final String? id;

  factory TranslationModel.fromJson(Map<String, dynamic>? json) =>
      TranslationModel(
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };

  Translation toEntity() {
    return Translation(
      en: en,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        en,
        id,
      ];
}

class TransliterationModel extends Equatable {
  const TransliterationModel({
    required this.en,
    required this.id,
  });

  final String? en;
  final String? id;

  factory TransliterationModel.fromJson(Map<String, dynamic>? json) =>
      TransliterationModel(
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };

  Transliteration toEntity() {
    return Transliteration(
      en: en,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        en,
        id,
      ];
}
