import 'package:dio/dio.dart';

String baseURL = "http://127.0.0.1:8000/api/v1";

final dio = Dio(
  BaseOptions(
    baseUrl: baseURL,
  ),
);
