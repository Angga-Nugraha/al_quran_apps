import 'package:al_quran_apps/domain/entities/detail_surah/verses_tafsir.dart';
import 'package:equatable/equatable.dart';

class VersesTafsirModel extends Equatable {
  const VersesTafsirModel({
    required this.id,
  });

  final IdModel id;

  factory VersesTafsirModel.fromJson(Map<String, dynamic> json) =>
      VersesTafsirModel(
        id: IdModel.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
      };

  VersesTafsir toEntity() => VersesTafsir(id: id.toEntity());

  @override
  List<Object?> get props => [id];
}

class IdModel extends Equatable {
  const IdModel({
    required this.short,
    required this.long,
  });

  final String short;
  final String long;

  factory IdModel.fromJson(Map<String, dynamic> json) => IdModel(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };

  Id toEntity() {
    return Id(short: short, long: long);
  }

  @override
  List<Object?> get props => [short, long];
}
