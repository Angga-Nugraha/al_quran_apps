import 'package:equatable/equatable.dart';

class Name extends Equatable {
  final String? short;
  final String? long;
  final Transliteration? transliteration;
  final Translation? translation;

  const Name(
      {required this.short,
      required this.long,
      required this.transliteration,
      required this.translation});

  @override
  List<Object?> get props => [
        short,
        long,
        transliteration,
        translation,
      ];
}

class Translation extends Equatable {
  final String? en;
  final String? id;

  const Translation({required this.en, this.id});

  @override
  List<Object?> get props => [
        en,
        id,
      ];
}

class Transliteration extends Equatable {
  final String? en;
  final String? id;

  const Transliteration({required this.en, this.id});

  @override
  List<Object?> get props => [
        en,
        id,
      ];
}
