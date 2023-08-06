part of 'search_surah_bloc.dart';

abstract class SearchSurahEvent extends Equatable {
  const SearchSurahEvent();

  @override
  List<Object> get props => [];
}

class OnQuerychange extends SearchSurahEvent {
  final String query;

  const OnQuerychange(this.query);
  @override
  List<Object> get props => [query];
}

class SearchClicked extends SearchSurahEvent {
  final bool search;

  const SearchClicked({this.search = true});

  @override
  List<Object> get props => [search];
}

class CancelClicked extends SearchSurahEvent {
  final bool search;

  const CancelClicked({this.search = false});

  @override
  List<Object> get props => [search];
}
