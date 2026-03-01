// ignore_for_file: constant_identifier_names

class StatusCodes {
  // Success Codes
  static const int OK_200 = 200;
  static const int CREATED_201 = 201;
  static const int ACCEPTED_202 = 202;
  static const int NO_CONTENT_204 = 204;

  // Client Error Codes
  static const int BAD_REQUEST_400 = 400;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND_404 = 404;
  static const int METHOD_NOT_ALLOWED = 405;
  static const int CONFLICT = 409;
  static const int UNPROCESSABLE_ENTITY = 422;

  // Server Error Codes
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_IMPLEMENTED = 501;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;

  static const int CONFLICT_409 = 409;
}
