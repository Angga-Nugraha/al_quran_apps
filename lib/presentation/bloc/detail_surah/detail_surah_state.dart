part of 'detail_surah_bloc.dart';

abstract class DetailSurahState extends Equatable {
  const DetailSurahState();

  @override
  List<Object> get props => [];
}

class DetailSurahEmpty extends DetailSurahState {}

class DetailSurahLoading extends DetailSurahState {}

class DetailSurahError extends DetailSurahState {
  final String message;
  const DetailSurahError({required this.message});

  @override
  List<Object> get props => [message];
}

class DetailSurahHasData extends DetailSurahState {
  final DetailSurah result;
  const DetailSurahHasData({required this.result});

  @override
  List<Object> get props => [result];
}
