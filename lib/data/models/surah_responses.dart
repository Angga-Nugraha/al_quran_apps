import 'package:equatable/equatable.dart';

import 'surah_model/surah_model.dart';

class SurahResponse extends Equatable {
  final List<SurahModel> surahList;

  const SurahResponse({required this.surahList});

  factory SurahResponse.fromJson(Map<String, dynamic> json) => SurahResponse(
        surahList: List<SurahModel>.from((json["data"] as List)
            .map((x) => SurahModel.fromJson(x))
            .where((element) =>
                element.number != null &&
                element.sequence != null &&
                element.numberOfVerses != null &&
                element.name != null &&
                element.revelation != null &&
                element.tafsir != null)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(surahList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [surahList];
}
