class NotMapDataFormat implements Exception {
  final String message;
  NotMapDataFormat({this.message = "Unexpected data format"});

  @override
  String toString() {
    return message;
  }
}
