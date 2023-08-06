import 'package:al_quran_apps/domain/entities/surah/revelation.dart';
import 'package:al_quran_apps/domain/entities/surah/tafsir.dart';
import 'package:equatable/equatable.dart';

import 'name.dart';

class Surah extends Equatable {
  final int? number;
  final int? sequence;
  final int? numberOfVerses;
  final Name? name;
  final Revelation? revelation;
  final Tafsir? tafsir;

  const Surah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
  });

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
