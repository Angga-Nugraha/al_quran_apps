part of 'list_surah_bloc.dart';

abstract class ListSurahState extends Equatable {
  const ListSurahState();

  @override
  List<Object> get props => [];
}

class SurahListEmpty extends ListSurahState {}

class SurahListLoading extends ListSurahState {}

class SurahListError extends ListSurahState {
  final String message;
  const SurahListError({required this.message});

  @override
  List<Object> get props => [message];
}

class SurahListHasData extends ListSurahState {
  final List<Surah> result;
  const SurahListHasData({required this.result});

  @override
  List<Object> get props => [result];
}
