class ResponseValidator {
  static bool isNotEmptyAndIsList(var data) {
    return data != null && data is List;
  }

  static bool isMap(var map) {
    return map is Map;
  }
}
