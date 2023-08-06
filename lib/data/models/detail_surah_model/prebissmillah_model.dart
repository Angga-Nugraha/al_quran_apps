import 'package:al_quran_apps/domain/entities/detail_surah/prebismillah.dart';
import 'package:equatable/equatable.dart';

import 'audio_model.dart';
import '../surah_model/name_model.dart';

class PreBismillahModel extends Equatable {
  const PreBismillahModel({this.text, this.translation, this.audio});

  final TextModel? text;
  final TransliterationModel? translation;
  final AudioModel? audio;

  factory PreBismillahModel.fromJson(Map<String, dynamic>? json) =>
      PreBismillahModel(
        text: TextModel.fromJson(json?["text"]),
        translation: TransliterationModel.fromJson(json?["translation"]),
        audio: AudioModel.fromJson(json?["audio"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text?.toJson(),
        "translation": translation?.toJson(),
        "audio": audio?.toJson(),
      };

  PreBismillah toEntity() {
    return PreBismillah(
        audio: audio!.toEntity(),
        text: text!.toEntity(),
        translation: translation!.toEntity());
  }

  @override
  List<Object?> get props => [
        text,
        translation,
        audio,
      ];
}

class TextModel extends Equatable {
  const TextModel({
    this.arab,
    this.transliteration,
  });

  final String? arab;
  final TransliterationModel? transliteration;

  factory TextModel.fromJson(Map<String, dynamic>? json) => TextModel(
        arab: json?["arab"],
        transliteration:
            TransliterationModel.fromJson(json?["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration?.toJson(),
      };
  Text toEntity() {
    return Text(arab: arab, transliteration: transliteration!.toEntity());
  }

  @override
  List<Object?> get props => [
        arab,
        transliteration,
      ];
}
