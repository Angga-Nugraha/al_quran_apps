import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';

class PlayAudio {
  final AudioRepositories audioRepositories;

  PlayAudio(this.audioRepositories);

  Future<void> execute() async {
    await audioRepositories.play();
  }
}
