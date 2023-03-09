class HttpException implements Exception {
  final int statusCode;

  HttpException(this.statusCode);

  @override
  String toString() {
    return statusCode.toString();
  }
}