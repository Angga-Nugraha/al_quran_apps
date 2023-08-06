import 'package:equatable/equatable.dart';

class Tafsir extends Equatable {
  final String? id;

  const Tafsir({this.id});

  @override
  List<Object?> get props => [id];
}
