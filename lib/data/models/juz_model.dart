import 'package:al_quran_apps/data/models/detail_surah_model/verses_model.dart';
import 'package:al_quran_apps/domain/entities/juz.dart';
import 'package:equatable/equatable.dart';

class JuzModel extends Equatable {
  const JuzModel({
    required this.juz,
    required this.juzStartSurahNumber,
    required this.juzEndSurahNumber,
    required this.juzStartInfo,
    required this.juzEndInfo,
    required this.totalVerses,
    required this.verses,
  });

  final int juz;
  final int juzStartSurahNumber;
  final int juzEndSurahNumber;
  final String juzStartInfo;
  final String juzEndInfo;
  final int totalVerses;
  final List<VersesModel> verses;

  factory JuzModel.fromJson(Map<String, dynamic> json) => JuzModel(
        juz: json["juz"],
        juzStartSurahNumber: json["juzStartSurahNumber"],
        juzEndSurahNumber: json["juzEndSurahNumber"],
        juzStartInfo: json["juzStartInfo"],
        juzEndInfo: json["juzEndInfo"],
        totalVerses: json["totalVerses"],
        verses: List<VersesModel>.from(
            json["verses"].map((x) => VersesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "juzStartSurahNumber": juzStartSurahNumber,
        "juzEndSurahNumber": juzEndSurahNumber,
        "juzStartInfo": juzStartInfo,
        "juzEndInfo": juzEndInfo,
        "totalVerses": totalVerses,
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
      };

  Juz toEntity() => Juz(
      juz: juz,
      juzStartSurahNumber: juzStartSurahNumber,
      juzEndSurahNumber: juzEndSurahNumber,
      juzStartInfo: juzStartInfo,
      juzEndInfo: juzEndInfo,
      totalVerses: totalVerses,
      verses: verses.map((e) => e.toEntity()).toList());

  @override
  List<Object?> get props => [
        juz,
        juzStartSurahNumber,
        juzEndSurahNumber,
        juzStartInfo,
        juzEndInfo,
        totalVerses,
        verses,
      ];
}
