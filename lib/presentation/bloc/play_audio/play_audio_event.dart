part of 'play_audio_bloc.dart';

abstract class PlayAudioEvent extends Equatable {
  const PlayAudioEvent();

  @override
  List<Object> get props => [];
}

class PlayAllAudioEvent extends PlayAudioEvent {}

class FinishedAudioEvent extends PlayAudioEvent {}

class PauseAudioEvent extends PlayAudioEvent {}
