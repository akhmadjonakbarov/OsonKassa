import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../features/shared/export_commons.dart';
import 'dio_config.dart';

class DioProvider {
  DioProvider();

  Dio createDio() {
    final TokenCtl tokenController = Get.find<TokenCtl>();

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] =
              'Bearer ${tokenController.token.value}';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
