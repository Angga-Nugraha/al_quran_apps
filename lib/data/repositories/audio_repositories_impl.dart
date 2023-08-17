import 'package:al_quran_apps/data/datasource/surah_data_source.dart';
import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class AudioRepositoriesImpl implements AudioRepositories {
  final AudioHandler audioHandler;
  final SurahDataSource surahDataSource;
  AudioRepositoriesImpl(
      {required this.audioHandler, required this.surahDataSource});

  @override
  Future<void> getPlayList(
      String title, String album, List<String> playlist) async {
    final newPlaylist = playlist.map((e) {
      return MediaItem(id: e, title: title, album: album, extras: {'url': e});
    }).toList();
    audioHandler.addQueueItems(newPlaylist);
    debugPrint("JUMLAH PLAYLIST : ${audioHandler.queue.value.length}");
  }

  @override
  Future<void> play() async {
    await audioHandler.play();
  }

  @override
  Future<void> pause() async {
    await audioHandler.pause();
  }

  @override
  Future<void> stop() async {
    await audioHandler.stop();
  }

  @override
  Future<void> seek(Duration duration) async {
    await audioHandler.seek(duration);
  }

  @override
  Future<void> dispose() async {
    await audioHandler.customAction('dispose');
  }

  @override
  Future<void> seekToNext() async {
    await audioHandler.skipToNext();
  }

  @override
  Future<void> seekToPrevius() async {
    await audioHandler.skipToPrevious();
  }
}
