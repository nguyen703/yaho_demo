/// Exception that caused from Server, most likely to have 5xx status code
class ServerException implements Exception {}

/// Exception that caused from parsing json
class ParsingException implements Exception {}

/// Exception that caused from user's network, most likely to have 4xx status code
class ClientNetworkException implements Exception {}

/// Unknown exception
class GeneralException implements Exception {}
