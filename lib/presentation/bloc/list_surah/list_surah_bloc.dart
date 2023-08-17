import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/surah/surah.dart';
import '../../../domain/usecases/surah/get_list_surah.dart';

part 'list_surah_event.dart';
part 'list_surah_state.dart';

class ListSurahBloc extends Bloc<ListSurahEvent, ListSurahState> {
  final GetListSurah getListSurah;
  ListSurahBloc({required this.getListSurah}) : super(SurahListEmpty()) {
    on<FetchNowListSurah>((event, emit) async {
      emit(SurahListLoading());
      final result = await getListSurah.execute();
      result.fold(
        (failure) => emit(SurahListError(message: failure.message)),
        (data) => emit(
          SurahListHasData(result: data),
        ),
      );
    });
  }
}
