import 'package:al_quran_apps/domain/usecases/audio/get_playlist.dart';
import 'package:al_quran_apps/domain/usecases/audio/pause_audio.dart';
import 'package:al_quran_apps/domain/usecases/audio/play_audio.dart';
import 'package:al_quran_apps/domain/usecases/audio/seek_audio.dart';
import 'package:al_quran_apps/domain/usecases/audio/stop_audio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'play_audio_event.dart';
part 'play_audio_state.dart';

class PlayAudioBloc extends Bloc<PlayAudioEvent, PlayAudioState> {
  GetPlaylist getPlaylist;
  PlayAudio playAudio;
  PauseAudio pauseAudio;
  StopAudio stopAudio;
  SeekAudio seekAudio;
  SkipToPreviuos skipToPreviuos;
  SkipToNext skipToNext;
  PlayAudioBloc({
    required this.getPlaylist,
    required this.playAudio,
    required this.pauseAudio,
    required this.stopAudio,
    required this.seekAudio,
    required this.skipToPreviuos,
    required this.skipToNext,
  }) : super(const PlayAudioInitial()) {
    on<FetchPlaylist>((event, emit) async {
      await getPlaylist.execute(event.title, event.album, event.playList);
      emit(PlayListHasData());
    });

    on<PlayAllAudioEvent>((event, emit) async {
      emit(const PlayingAudioState(true));
      await playAudio
          .execute()
          .then((value) => emit(const FinishedAudioState(false)));
    });
    on<PauseAudioEvent>((event, emit) async {
      emit(const PauseAudioState(false));
      await pauseAudio.execute();
    });

    on<ReplayAudioEvent>((event, emit) async {
      await seekAudio.execute(Duration.zero);
    });
    on<StopAudioEvent>((event, emit) async {
      emit(const FinishedAudioState(false));
      stopAudio.execute();
    });
    on<SeekToPrevious>((event, emit) async {
      await skipToPreviuos.execute();
    });
    on<SeekToNext>((event, emit) async {
      await skipToNext.execute();
    });
  }
}
