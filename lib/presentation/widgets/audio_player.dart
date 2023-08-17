import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:al_quran_apps/presentation/bloc/play_audio/play_audio_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioHelper {
  final AudioPlayer audioPlayer;

  const AudioHelper({required this.audioPlayer});

  List<String> getAudio(List<Verses> verses, {String? hasBismillah}) {
    List<String> result = [];

    if (hasBismillah != null) {
      result.add(hasBismillah);
    }
    for (var ayat in verses) {
      result.add(ayat.audio!.primary!);
    }
    return result;
  }

  Future<void> playList(BuildContext context, List<String> url) async {
    context.read<PlayAudioBloc>().add(PlayAllAudioEvent());
    if (audioPlayer.state == PlayerState.paused) {
      resume();
    } else {
      await audioPlayer.play(UrlSource(url[0]));
      int i = 1;
      audioPlayer.onPlayerComplete.listen((_) {
        if (i < url.length) {
          audioPlayer.play(UrlSource(url[i]));
          i++;
        } else {
          stop(context);
        }
      });
    }
  }

  Future<void> pause(BuildContext context) async {
    context.read<PlayAudioBloc>().add(PauseAudioEvent());
    await audioPlayer.pause();
    audioPlayer.state == PlayerState.paused;
  }

  Future<void> resume() async {
    await audioPlayer.resume();
    audioPlayer.state == PlayerState.playing;
  }

  Future<void> stop(BuildContext context) async {
    context.read<PlayAudioBloc>().add(ReplayAudioEvent());
    await audioPlayer.stop();
    audioPlayer.state == PlayerState.stopped;
  }

  Future<void> close() async {
    await audioPlayer.dispose();
  }
}
