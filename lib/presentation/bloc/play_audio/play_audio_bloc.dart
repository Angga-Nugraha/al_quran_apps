import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'play_audio_event.dart';
part 'play_audio_state.dart';

class PlayAudioBloc extends Bloc<PlayAudioEvent, PlayAudioState> {
  PlayAudioBloc() : super(PlayAudioInitial()) {
    on<PlayAllAudioEvent>((event, emit) {
      emit(PlayingAudioState());
    });

    on<PauseAudioEvent>((event, emit) {
      emit(PauseAudioState());
    });

    on<FinishedAudioEvent>((event, emit) {
      emit(FinishedAudioState());
    });
  }
}
