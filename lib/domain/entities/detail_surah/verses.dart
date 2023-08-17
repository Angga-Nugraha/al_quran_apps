import 'package:equatable/equatable.dart';

import 'audio.dart';
import '../surah/name.dart';
import 'prebismillah.dart';
import 'verses_tafsir.dart';

class Verses extends Equatable {
  final Number? number;
  final Meta? meta;
  final TextAyat? text;
  final Translation? translation;
  final Audio? audio;
  final VersesTafsir? tafsir;

  const Verses({
    this.number,
    this.meta,
    this.text,
    this.translation,
    this.audio,
    this.tafsir,
  });

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

class Number extends Equatable {
  final int? inQuran;
  final int? inSurah;

  const Number({
    this.inQuran,
    this.inSurah,
  });

  @override
  List<Object?> get props => [
        inQuran,
        inSurah,
      ];
}

class Meta extends Equatable {
  final int? juz;
  final int? page;
  final int? manzil;
  final int? ruku;
  final int? hizbQuarter;

  const Meta({
    this.juz,
    this.page,
    this.manzil,
    this.ruku,
    this.hizbQuarter,
  });

  @override
  List<Object?> get props => [
        juz,
        page,
        manzil,
        ruku,
        hizbQuarter,
      ];
}
