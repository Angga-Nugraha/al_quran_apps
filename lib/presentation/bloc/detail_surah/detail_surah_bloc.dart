import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/detail_surah/detail_surah.dart';
import '../../../domain/usecases/get_detail_surah.dart';

part 'detail_surah_event.dart';
part 'detail_surah_state.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final GetDetailSurah getDetailSurah;

  DetailSurahBloc({required this.getDetailSurah}) : super(DetailSurahEmpty()) {
    on<FetchDetailSurah>((event, emit) async {
      final number = event.number;
      emit(DetailSurahLoading());
      final result = await getDetailSurah.execute(number);
      result.fold(
        (failure) => emit(DetailSurahError(message: failure.message)),
        (data) => emit(DetailSurahHasData(result: data)),
      );
    });
  }
}
