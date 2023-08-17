import 'package:equatable/equatable.dart';

import 'audio.dart';
import '../surah/name.dart';

class PreBismillah extends Equatable {
  final TextAyat? text;
  final Transliteration? translation;
  final Audio? audio;

  const PreBismillah({this.text, this.translation, this.audio});

  @override
  List<Object?> get props => [
        text,
        translation,
        audio,
      ];
}

class TextAyat extends Equatable {
  final String? arab;
  final Transliteration? transliteration;

  const TextAyat({this.arab, this.transliteration});

  @override
  List<Object?> get props => [
        arab,
        transliteration,
      ];
}
