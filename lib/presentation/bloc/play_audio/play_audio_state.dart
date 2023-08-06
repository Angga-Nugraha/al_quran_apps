part of 'play_audio_bloc.dart';

abstract class PlayAudioState extends Equatable {
  const PlayAudioState();

  @override
  List<Object> get props => [];
}

class PlayAudioInitial extends PlayAudioState {}

class PauseAudioState extends PlayAudioState {}

class PlayingAudioState extends PlayAudioState {}

class FinishedAudioState extends PlayAudioState {}
