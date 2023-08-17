import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';

class StopAudio {
  AudioRepositories audioRepositories;

  StopAudio(this.audioRepositories);

  Future<void> execute() async {
    await audioRepositories.stop();
  }
}
