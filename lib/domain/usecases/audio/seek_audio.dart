import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';

class SeekAudio {
  AudioRepositories audioRepositories;

  SeekAudio(this.audioRepositories);

  Future<void> execute(Duration duration) async {
    await audioRepositories.seek(duration);
  }
}

class SkipToPreviuos {
  AudioRepositories audioRepositories;

  SkipToPreviuos(this.audioRepositories);

  Future<void> execute() async {
    await audioRepositories.seekToPrevius();
  }
}

class SkipToNext {
  AudioRepositories audioRepositories;

  SkipToNext(this.audioRepositories);

  Future<void> execute() async {
    await audioRepositories.seekToNext();
  }
}
