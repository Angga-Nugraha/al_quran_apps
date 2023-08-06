part of 'search_surah_bloc.dart';

abstract class SearchSurahState extends Equatable {
  const SearchSurahState();

  @override
  List<Object> get props => [];
}

class SearchSurahInitial extends SearchSurahState {}

class SearchSurahError extends SearchSurahState {
  final String message;

  const SearchSurahError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchSurahHasData extends SearchSurahState {
  final List<Surah> result;

  const SearchSurahHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class SearchHasClicked extends SearchSurahState {
  final bool search;

  const SearchHasClicked({required this.search});

  @override
  List<Object> get props => [search];
}

class CancelHasData extends SearchSurahState {
  final bool search;

  const CancelHasData({required this.search});

  @override
  List<Object> get props => [search];
}
