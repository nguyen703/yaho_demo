abstract class Failure {
  Failure({this.message});

  final String? message;
}

/// Failure that caused from Server, most likely to have 5xx status code
class ServerFailure extends Failure {
  ServerFailure() : super(message: "Errors occurred from the server.");
}

/// Failure that caused from parsing json
class ParsingFailure extends Failure {
  ParsingFailure() : super(message: "Errors occurred while parsing the data.");
}

/// Failure that caused from user's network, most likely to have 4xx status code
class ClientNetworkFailure extends Failure {
  ClientNetworkFailure()
      : super(message: "Errors occurred when connecting to the server.");
}

class GeneralFailure extends Failure {
  GeneralFailure() : super(message: "Unknown errors occurred.");
}
