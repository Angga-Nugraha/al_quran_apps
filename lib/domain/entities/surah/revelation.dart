import 'package:equatable/equatable.dart';

class Revelation extends Equatable {
  final String? arab;
  final String? en;
  final String? id;

  const Revelation({this.arab, this.en, this.id});

  @override
  List<Object?> get props => [
        arab,
        en,
        id,
      ];
}
