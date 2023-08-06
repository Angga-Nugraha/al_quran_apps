import 'dart:convert';

import 'package:al_quran_apps/data/models/surah_model/name_model.dart';
import 'package:al_quran_apps/data/models/surah_model/revelation_model.dart';
import 'package:al_quran_apps/data/models/surah_model/surah_model.dart';
import 'package:al_quran_apps/data/models/surah_model/tafsir_model.dart';
import 'package:al_quran_apps/domain/entities/surah/surah.dart';
import 'package:equatable/equatable.dart';

class SurahTable extends Equatable {
  const SurahTable({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
  });

  final int number;
  final int sequence;
  final int numberOfVerses;
  final String name;
  final String revelation;
  final String tafsir;

  factory SurahTable.fromMap(Map<String, dynamic> map) => SurahTable(
        number: map["number"],
        sequence: map["sequence"],
        numberOfVerses: map["numberOfVerses"],
        name: map['name'],
        revelation: map["revelation"],
        tafsir: map["tafsir"],
      );

  factory SurahTable.fromDTO(SurahModel surah) => SurahTable(
        number: surah.number!,
        sequence: surah.sequence!,
        numberOfVerses: surah.numberOfVerses!,
        name: json.encode(surah.name!),
        revelation: json.encode(surah.revelation!),
        tafsir: json.encode(surah.tafsir!),
      );

  Surah toEntity() => Surah(
      number: number,
      sequence: sequence,
      numberOfVerses: numberOfVerses,
      name: NameModel.fromJson(json.decode(name)).toEntity(),
      revelation: RevelationModel.fromJson(json.decode(revelation)).toEntity(),
      tafsir: TafsirModel.fromJson(json.decode(tafsir)).toEntity());

  Map<String, dynamic> toJson() => {
        'number': number,
        'sequence': sequence,
        'numberOfVerses': numberOfVerses,
        'name': name,
        'revelation': revelation,
        'tafsir': tafsir,
      };

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
