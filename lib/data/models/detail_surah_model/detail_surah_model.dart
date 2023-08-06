import 'package:al_quran_apps/data/models/surah_model/name_model.dart';
import 'package:al_quran_apps/domain/entities/detail_surah/detail_surah.dart';
import 'package:equatable/equatable.dart';

import 'prebissmillah_model.dart';
import '../surah_model/revelation_model.dart';
import '../surah_model/tafsir_model.dart';
import 'verses_model.dart';

class DetailSurahModel extends Equatable {
  const DetailSurahModel({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
    required this.preBismillah,
    required this.verses,
  });

  final int? number;
  final int sequence;
  final int numberOfVerses;
  final NameModel? name;
  final RevelationModel? revelation;
  final TafsirModel? tafsir;
  final PreBismillahModel? preBismillah;
  final List<VersesModel>? verses;

  factory DetailSurahModel.fromJson(Map<String, dynamic>? json) =>
      DetailSurahModel(
        number: json?["number"],
        sequence: json?["sequence"],
        numberOfVerses: json?["numberOfVerses"],
        name: NameModel.fromJson(json?["name"]),
        revelation: RevelationModel.fromJson(json?["revelation"]),
        tafsir: TafsirModel.fromJson(json?["tafsir"]),
        preBismillah: PreBismillahModel.fromJson(json?["preBismillah"]),
        verses: json?["verses"] == null
            ? null
            : List<VersesModel>.from(
                json?["verses"].map((x) => VersesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name!.toJson(),
        "revelation": revelation!.toJson(),
        "tafsir": tafsir!.toJson(),
        "preBismillah": preBismillah!.toJson(),
        "verses": verses == null
            ? null
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
      };

  DetailSurah toEntity() {
    return DetailSurah(
        name: name!.toEntity(),
        number: number!,
        numberOfVerses: numberOfVerses,
        preBismillah: preBismillah!.toEntity(),
        revelation: revelation!.toEntity(),
        sequence: sequence,
        tafsir: tafsir!.toEntity(),
        verses: verses?.map((e) => e.toEntity()).toList() ?? []);
  }

  @override
  List<Object?> get props => [
        number,
        sequence,
        numberOfVerses,
        name,
        revelation,
        tafsir,
        preBismillah,
        verses,
      ];
}
