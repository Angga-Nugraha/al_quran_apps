import 'package:al_quran_apps/domain/entities/surah/revelation.dart';
import 'package:equatable/equatable.dart';

class RevelationModel extends Equatable {
  const RevelationModel({
    required this.arab,
    required this.en,
    required this.id,
  });

  final String? arab;
  final String? en;
  final String? id;

  factory RevelationModel.fromJson(Map<String, dynamic>? json) =>
      RevelationModel(
        arab: json?["arab"],
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
      };
  Revelation toEntity() {
    return Revelation(
      arab: arab,
      en: en,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        arab,
        en,
        id,
      ];
}
