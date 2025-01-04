class AuthUserNotFoundException implements Exception {
  final String message;
  AuthUserNotFoundException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class LoginOrPasswordWrongException implements Exception {
  final String message;
  LoginOrPasswordWrongException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class TokenInvalidException implements Exception {
  final String message;
  TokenInvalidException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class AlreadyExistException implements Exception {
  final String message;
  AlreadyExistException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class BarcodeAlreadyExistException implements Exception {
  final String message;
  BarcodeAlreadyExistException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class InvalidDataException implements Exception {
  final String message;
  InvalidDataException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class DataNotFoundException implements Exception {
  final String message;
  DataNotFoundException({required this.message});
  @override
  String toString() => message;
}

class NotEnoughQuantity implements Exception {
  final String message;
  NotEnoughQuantity({required this.message});
  @override
  String toString() => message;
}
