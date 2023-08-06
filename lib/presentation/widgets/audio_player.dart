import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/play_audio/play_audio_bloc.dart';

class AudioHelper extends StatefulWidget {
  const AudioHelper({Key? key, required this.listAudio}) : super(key: key);

  final List<String> listAudio;

  @override
  State<AudioHelper> createState() => _AudioHelperState();
}

class _AudioHelperState extends State<AudioHelper> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  static IconData playButton = Icons.play_circle_outline_outlined;
  static String title = 'Play all';
  static int index = 0;

  void playAll(BuildContext context, List<String> urlList, int curentIndex) {
    next(context, urlList, curentIndex);
  }

  void next(
    BuildContext context,
    List<String> urlList,
    int curentIndex,
  ) async {
    await _audioPlayer.play(UrlSource(urlList[curentIndex]));
    _audioPlayer.onPlayerComplete.listen((event) {
      if (curentIndex < urlList.length - 1) {
        curentIndex++;
        playAll(context, urlList, curentIndex);
      } else {
        context.read<PlayAudioBloc>().add(FinishedAudioEvent());
      }
    });
  }

  void close() async {
    await _audioPlayer.dispose();
  }

  void release() async {
    await _audioPlayer.release();
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void resume() async {
    await _audioPlayer.resume();
  }

  @override
  void initState() {
    Future.microtask(() => Provider.of<PlayAudioBloc>(context, listen: false)
        .add(FinishedAudioEvent()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayAudioBloc, PlayAudioState>(
      listener: (context, state) {
        if (state is PlayingAudioState) {
          playButton = Icons.pause_circle_outline_outlined;
          title = 'Pause';
          _audioPlayer.state == PlayerState.playing;
        } else if (state is PauseAudioState) {
          _audioPlayer.state == PlayerState.paused;
          playButton = Icons.play_circle_outline_outlined;
          title = 'Play';
        } else if (state is FinishedAudioState) {
          _audioPlayer.state == PlayerState.stopped;
          playButton = Icons.play_circle_outline_outlined;
          title = 'Play All';
          release();
        }
      },
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              switch (_audioPlayer.state) {
                case PlayerState.playing:
                  pause();
                  context.read<PlayAudioBloc>().add(PauseAudioEvent());
                  break;
                case PlayerState.paused:
                  resume();
                  context.read<PlayAudioBloc>().add(PlayAllAudioEvent());
                  break;
                case PlayerState.stopped:
                  playAll(context, widget.listAudio, index);
                  context.read<PlayAudioBloc>().add(PlayAllAudioEvent());
                  break;
                default:
                  break;
              }
            },
            icon: Icon(
              playButton,
              size: 35,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
