import 'package:al_quran_apps/domain/entities/detail_surah/audio.dart';
import 'package:equatable/equatable.dart';

class AudioModel extends Equatable {
  const AudioModel({this.primary, this.secondary});

  final String? primary;
  final List<String>? secondary;

  factory AudioModel.fromJson(Map<String, dynamic>? json) => AudioModel(
        primary: json?["primary"],
        secondary: json?["secondary"] == null
            ? null
            : List<String>.from(json!["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary == null
            ? null
            : List<dynamic>.from(secondary!.map((x) => x)),
      };
  Audio toEntity() {
    return Audio(
      primary: primary,
      secondary: secondary,
    );
  }

  @override
  List<Object?> get props => [
        primary,
        secondary,
      ];
}
