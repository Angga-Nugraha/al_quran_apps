import 'package:al_quran_apps/domain/usecases/surah/search_surah.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/surah/surah.dart';

part 'search_surah_event.dart';
part 'search_surah_state.dart';

class SearchSurahBloc extends Bloc<SearchSurahEvent, SearchSurahState> {
  SearchSurah searchSurah;
  SearchSurahBloc({required this.searchSurah}) : super(SearchSurahInitial()) {
    on<SearchClicked>((event, emit) {
      emit(SearchHasClicked(search: event.search));
    });

    on<CancelClicked>((event, emit) {
      emit(CancelHasData(search: event.search));
    });

    on<OnQuerychange>((event, emit) async {
      final result = await searchSurah.execute(event.query);
      result.fold(
          (falilure) => emit(SearchSurahError(message: falilure.message)),
          (data) => emit(SearchSurahHasData(result: data)));
    });
  }
}
