import 'package:equatable/equatable.dart';

class LastReadTable extends Equatable {
  const LastReadTable({
    required this.number,
    required this.name,
    required this.juz,
    required this.ayat,
  });

  final int number;
  final String name;
  final int juz;
  final int ayat;

  factory LastReadTable.fromMap(Map<String, dynamic> map) => LastReadTable(
        number: map["surah_number"],
        name: map['surah_name'],
        juz: map["juz"],
        ayat: map["ayat"],
      );

  Map<String, dynamic> toJson() => {
        'surah_number': number,
        'surah_name': name,
        'juz': juz,
        'ayat': ayat,
      };

  @override
  List<Object?> get props => [
        number,
        name,
        juz,
        ayat,
      ];
}
