import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';

class PauseAudio {
  AudioRepositories audioRepositories;

  PauseAudio(this.audioRepositories);
  Future<void> execute() async {
    await audioRepositories.pause();
  }
}
