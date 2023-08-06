import 'package:al_quran_apps/data/models/surah_model/name_model.dart';
import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:equatable/equatable.dart';

import 'audio_model.dart';
import 'prebissmillah_model.dart';
import 'verses_tafsir_model.dart';

class VersesModel extends Equatable {
  const VersesModel({
    this.number,
    this.meta,
    this.text,
    this.translation,
    this.audio,
    this.tafsir,
  });

  final NumberModel? number;
  final MetaModel? meta;
  final TextModel? text;
  final TranslationModel? translation;
  final AudioModel? audio;
  final VersesTafsirModel? tafsir;

  factory VersesModel.fromJson(Map<String, dynamic>? json) => VersesModel(
        number: NumberModel.fromJson(json?["number"]),
        meta: MetaModel.fromJson(json?["meta"]),
        text: TextModel.fromJson(json?["text"]),
        translation: TranslationModel.fromJson(json?["translation"]),
        audio: AudioModel.fromJson(json?["audio"]),
        tafsir: VersesTafsirModel.fromJson(json?["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number?.toJson(),
        "meta": meta?.toJson(),
        "text": text?.toJson(),
        "translation": translation?.toJson(),
        "audio": audio?.toJson(),
        "tafsir": tafsir?.toJson(),
      };

  Verses toEntity() {
    return Verses(
      audio: audio!.toEntity(),
      meta: meta!.toEntity(),
      number: number!.toEntity(),
      tafsir: tafsir!.toEntity(),
      text: text!.toEntity(),
      translation: translation!.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        number,
        meta,
        text,
        translation,
        audio,
        tafsir,
      ];
}

class NumberModel extends Equatable {
  final int? inQuran;
  final int? inSurah;

  const NumberModel({
    required this.inQuran,
    required this.inSurah,
  });

  factory NumberModel.fromJson(Map<String, dynamic>? json) => NumberModel(
        inQuran: json?["inQuran"],
        inSurah: json?["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };

  Number toEntity() {
    return Number(
      inQuran: inQuran,
      inSurah: inSurah,
    );
  }

  @override
  List<Object?> get props => [
        inQuran,
        inSurah,
      ];
}

class MetaModel extends Equatable {
  final int? juz;
  final int? page;
  final int? manzil;
  final int? ruku;
  final int? hizbQuarter;

  const MetaModel({
    this.juz,
    this.page,
    this.manzil,
    this.ruku,
    this.hizbQuarter,
  });

  factory MetaModel.fromJson(Map<String, dynamic>? json) => MetaModel(
        juz: json?["juz"],
        page: json?["page"],
        manzil: json?["manzil"],
        ruku: json?["ruku"],
        hizbQuarter: json?["hizbQuarter"],
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
      };

  Meta toEntity() {
    return Meta(
      hizbQuarter: hizbQuarter,
      juz: juz,
      manzil: manzil,
      page: page,
      ruku: ruku,
    );
  }

  @override
  List<Object?> get props => [
        juz,
        page,
        manzil,
        ruku,
        hizbQuarter,
      ];
}
