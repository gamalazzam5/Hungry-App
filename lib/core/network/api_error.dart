class ApiError {
  final String message;
  final int? statusCode;

  const ApiError({required this.message, this.statusCode});

  @override
  String toString() {
    return 'The server responded with an Error because $message with Status code $statusCode';
  }
}
