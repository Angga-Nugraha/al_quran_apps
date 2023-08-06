import 'package:equatable/equatable.dart';

import '../surah/name.dart';
import 'prebismillah.dart';
import '../surah/revelation.dart';
import '../surah/tafsir.dart';
import 'verses.dart';

class DetailSurah extends Equatable {
  const DetailSurah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
    required this.preBismillah,
    required this.verses,
  });

  final int number;
  final int sequence;
  final int numberOfVerses;
  final Name name;
  final Revelation revelation;
  final Tafsir tafsir;
  final PreBismillah preBismillah;
  final List<Verses> verses;

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
