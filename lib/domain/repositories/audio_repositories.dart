abstract class AudioRepositories {
  Future<void> getPlayList(String title, String album, List<String> playlist);
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration duration);
  Future<void> seekToPrevius();
  Future<void> seekToNext();
  Future<void> dispose();
}
