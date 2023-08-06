import 'package:al_quran_apps/domain/entities/surah/tafsir.dart';
import 'package:equatable/equatable.dart';

class TafsirModel extends Equatable {
  const TafsirModel({
    required this.id,
  });

  final String? id;

  factory TafsirModel.fromJson(Map<String, dynamic>? json) => TafsirModel(
        id: json?["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
  Tafsir toEntity() {
    return Tafsir(id: id);
  }

  @override
  List<Object?> get props => [id];
}
