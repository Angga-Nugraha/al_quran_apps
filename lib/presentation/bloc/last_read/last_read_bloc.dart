import 'package:al_quran_apps/domain/usecases/surah/get_last_read.dart';
import 'package:al_quran_apps/domain/usecases/surah/insert_last_read.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'last_read_event.dart';
part 'last_read_state.dart';

class LastReadBloc extends Bloc<LastReadEvent, LastReadState> {
  final InsertLastRead insertLastRead;
  final GetLastRead getLastRead;
  LastReadBloc({required this.insertLastRead, required this.getLastRead})
      : super(LastReadInitial()) {
    on<InsertLastReadEvent>((event, emit) async {
      final result = await insertLastRead.execute(event.surah);
      result.fold(
        (failure) => emit(LastReadHasError(message: failure.message)),
        (data) => emit(LastReadHasSuccess(result: data)),
      );
      add(GetLastReadEvent());
    });
    on<GetLastReadEvent>((event, emit) async {
      final result = await getLastRead.execute();
      result.fold(
        (failure) => emit(LastReadHasError(message: failure.message)),
        (data) => emit(LastReadHasData(result: data)),
      );
    });
  }
}
