class ErrorHandler {
  final String message;

  ErrorHandler(this.message);
}

class Failure extends ErrorHandler {
  Failure(super.message);
}
