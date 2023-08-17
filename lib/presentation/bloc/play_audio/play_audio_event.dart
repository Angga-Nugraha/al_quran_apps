part of 'play_audio_bloc.dart';

abstract class PlayAudioEvent extends Equatable {
  const PlayAudioEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaylist extends PlayAudioEvent {
  final String title;
  final String album;
  final List<String> playList;
  const FetchPlaylist(
      {required this.title, required this.album, required this.playList});

  @override
  List<Object> get props => [title, album, playList];
}

class FetchPlaylistJuz extends PlayAudioEvent {
  final int id;
  const FetchPlaylistJuz(this.id);

  @override
  List<Object> get props => [id];
}

class PlayAllAudioEvent extends PlayAudioEvent {}

class ReplayAudioEvent extends PlayAudioEvent {}

class StopAudioEvent extends PlayAudioEvent {}

class SeekToPrevious extends PlayAudioEvent {}

class SeekToNext extends PlayAudioEvent {}

class PauseAudioEvent extends PlayAudioEvent {}
