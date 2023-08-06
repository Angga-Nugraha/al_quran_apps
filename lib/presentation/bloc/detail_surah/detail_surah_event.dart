part of 'detail_surah_bloc.dart';

abstract class DetailSurahEvent extends Equatable {
  const DetailSurahEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailSurah extends DetailSurahEvent {
  final int number;

  const FetchDetailSurah(this.number);

  @override
  List<Object> get props => [number];
}
