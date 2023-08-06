import 'package:al_quran_apps/domain/entities/surah/surah.dart';
import 'package:equatable/equatable.dart';

import 'name_model.dart';
import 'revelation_model.dart';
import 'tafsir_model.dart';

class SurahModel extends Equatable {
  const SurahModel({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
  });

  final int? number;
  final int? sequence;
  final int? numberOfVerses;
  final NameModel? name;
  final RevelationModel? revelation;
  final TafsirModel? tafsir;

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        number: json["number"],
        sequence: json["sequence"],
        numberOfVerses: json["numberOfVerses"],
        name: NameModel.fromJson(json["name"]),
        revelation: RevelationModel.fromJson(json["revelation"]),
        tafsir: TafsirModel.fromJson(json["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name!.toJson(),
        "revelation": revelation!.toJson(),
        "tafsir": tafsir!.toJson(),
      };

  Surah toEntity() {
    return Surah(
        number: number,
        sequence: sequence,
        numberOfVerses: numberOfVerses,
        name: name!.toEntity(),
        revelation: revelation!.toEntity(),
        tafsir: tafsir!.toEntity());
  }

  @override
  List<Object?> get props => [
        number,
        sequence,
        numberOfVerses,
        name,
        revelation,
        tafsir,
      ];
}
