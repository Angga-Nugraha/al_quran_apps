part of 'juz_bloc.dart';

abstract class JuzEvent extends Equatable {
  const JuzEvent();

  @override
  List<Object> get props => [];
}

class FetchSurahJuz extends JuzEvent {
  final int number;

  const FetchSurahJuz({required this.number});

  @override
  List<Object> get props => [number];
}
