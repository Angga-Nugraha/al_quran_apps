import 'package:equatable/equatable.dart';

class Audio extends Equatable {
  final String? primary;
  final List<String>? secondary;

  const Audio({required this.primary, required this.secondary});

  @override
  List<Object?> get props => [
        primary,
        secondary,
      ];
}
