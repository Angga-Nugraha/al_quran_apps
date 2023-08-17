import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';

class GetPlaylist {
  final AudioRepositories audioRepositories;

  GetPlaylist(this.audioRepositories);

  Future<void> execute(
      String title, String album, List<String> playlist) async {
    await audioRepositories.getPlayList(title, album, playlist);
  }
}
