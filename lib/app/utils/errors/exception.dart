class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class FirebaseDatabaseException implements Exception {
  final String message;

  FirebaseDatabaseException(this.message);
}
