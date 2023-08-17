import 'package:al_quran_apps/presentation/bloc/play_audio/play_audio_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_quran_apps/injection.dart' as di;

class AudioManager extends StatefulWidget {
  final String title;
  final String album;
  final List<String> playList;
  const AudioManager(
      {required this.title,
      required this.album,
      required this.playList,
      super.key});

  @override
  State<AudioManager> createState() => _AudioManagerState();
}

class _AudioManagerState extends State<AudioManager> {
  static bool isPlaying = false;

  @override
  void initState() {
    Future.microtask(() => [
          di.locator<AudioHandler>(),
          BlocProvider.of<PlayAudioBloc>(context, listen: false).add(
              FetchPlaylist(
                  title: widget.title,
                  album: widget.album,
                  playList: widget.playList)),
        ]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayAudioBloc, PlayAudioState>(
      listener: (context, state) {
        if (state is PlayingAudioState) {
          isPlaying = state.result;
        }
        if (state is PauseAudioState) {
          isPlaying = state.result;
        }
        if (state is FinishedAudioState) {
          isPlaying = state.result;
        }
      },
      builder: (context, state) {
        return Wrap(
          children: [
            IconButton(
              onPressed: () {
                context.read<PlayAudioBloc>().add(SeekToPrevious());
              },
              icon: const Icon(Icons.skip_previous),
              tooltip: "Previous",
            ),
            IconButton(
              onPressed: () {
                context.read<PlayAudioBloc>().add(StopAudioEvent());
              },
              icon: const Icon(Icons.stop_rounded),
              tooltip: "Stop",
            ),
            IconButton(
              onPressed: () {
                context.read<PlayAudioBloc>().add(ReplayAudioEvent());
              },
              icon: const Icon(Icons.replay_rounded, size: 16),
              tooltip: "Replay",
            ),
            IconButton(
              onPressed: () {
                isPlaying
                    ? context.read<PlayAudioBloc>().add(PauseAudioEvent())
                    : context.read<PlayAudioBloc>().add(PlayAllAudioEvent());
              },
              icon: isPlaying
                  ? const Icon(Icons.pause_outlined)
                  : const Icon(Icons.play_arrow_rounded),
              tooltip: "Play/Pause",
            ),
            IconButton(
              onPressed: () {
                context.read<PlayAudioBloc>().add(SeekToNext());
              },
              icon: const Icon(Icons.skip_next_rounded),
              tooltip: "Next",
            ),
          ],
        );
      },
    );
  }
}
