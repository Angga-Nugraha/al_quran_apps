part of 'play_audio_bloc.dart';

abstract class PlayAudioState extends Equatable {
  const PlayAudioState();

  @override
  List<Object> get props => [];
}

class PlayListHasData extends PlayAudioState {}

class PlayListJuzHasData extends PlayAudioState {}

class PlayListHasError extends PlayAudioState {
  final String message;
  const PlayListHasError({required this.message});

  @override
  List<Object> get props => [message];
}

class PlayAudioInitial extends PlayAudioState {
  final bool result;
  const PlayAudioInitial({this.result = false});

  @override
  List<Object> get props => [result];
}

class PauseAudioState extends PlayAudioState {
  final bool result;
  const PauseAudioState(this.result);

  @override
  List<Object> get props => [result];
}

class PlayingAudioState extends PlayAudioState {
  final bool result;
  const PlayingAudioState(this.result);

  @override
  List<Object> get props => [result];
}

class FinishedAudioState extends PlayAudioState {
  final bool result;
  const FinishedAudioState(this.result);

  @override
  List<Object> get props => [result];
}
