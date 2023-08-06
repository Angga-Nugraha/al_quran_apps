import 'package:al_quran_apps/domain/usecases/get_surah_juz.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/juz.dart';

part 'juz_event.dart';
part 'juz_state.dart';

class JuzBloc extends Bloc<JuzEvent, JuzState> {
  final GetSurahJuz getSurahJuz;

  JuzBloc({required this.getSurahJuz}) : super(JuzInitial()) {
    on<FetchSurahJuz>((event, emit) async {
      emit(JuzLoading());

      final number = event.number;
      final result = await getSurahJuz.execute(number);
      result.fold(
        (failure) => emit(JuzError(message: failure.message)),
        (data) => emit(JuzLoaded(result: data)),
      );
    });
  }
}
