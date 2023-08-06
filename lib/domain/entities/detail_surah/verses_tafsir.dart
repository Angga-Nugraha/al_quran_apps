import 'package:equatable/equatable.dart';

class VersesTafsir extends Equatable {
  const VersesTafsir({
    required this.id,
  });

  final Id id;

  @override
  List<Object?> get props => [id];
}

class Id extends Equatable {
  const Id({
    required this.short,
    required this.long,
  });

  final String short;
  final String long;

  @override
  List<Object?> get props => [short, long];
}
