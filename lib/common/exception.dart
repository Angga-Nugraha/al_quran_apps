class ServerException implements Exception {}

class CacheException implements Exception {
  String message;

  CacheException(this.message);
}
