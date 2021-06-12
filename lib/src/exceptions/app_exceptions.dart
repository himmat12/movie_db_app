class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  String toString() => '$_prefix$_message';
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}

class TimeOutException extends AppException {
  TimeOutException([String? message]) : super(message, 'Timeout: ');
}
