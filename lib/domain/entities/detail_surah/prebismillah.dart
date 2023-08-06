import 'package:equatable/equatable.dart';

import 'audio.dart';
import '../surah/name.dart';

class PreBismillah extends Equatable {
  final Text? text;
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

class Text extends Equatable {
  final String? arab;
  final Transliteration? transliteration;

  const Text({this.arab, this.transliteration});

  @override
  List<Object?> get props => [
        arab,
        transliteration,
      ];
}
