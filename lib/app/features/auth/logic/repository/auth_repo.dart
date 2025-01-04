import 'package:dio/dio.dart';

import '../../../../config/dio_config.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/network/status_codes.dart';
import '../../models/user_model.dart';

class AuthRepo {
  Future<UserModel?> login(
      {required String email, required String password}) async {
    try {
      UserModel? userModel;
      Response response = await dio
          .post('/auth/login', data: {"email": email, "password": password});
      if (response.statusCode == StatusCodes.OK_200) {
        Map<String, dynamic> userData = response.data['data']['item'];

        userModel = UserModel.fromMap(userData);
      }

      return userModel;
    } on DioException catch (error) {
      if (error.response!.statusCode == StatusCodes.BAD_REQUEST_400) {
        String errorMessage = "";
        errorMessage = error.response!.data['data']['message'];
        throw InvalidDataException(message: errorMessage);
      }
      if (error.response != null) {
        String errorMessage = "";
        errorMessage = error.response!.data['message'];
        throw InvalidDataException(message: errorMessage);
      } else {
        rethrow;
      }
    }
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String password2,
    required String last_name,
    required String first_name,
  }) async {
    try {
      UserModel? userModel;
      Response response = await dio.post('/auth/register', data: {
        "email": email,
        "password": password,
        "password2": password2,
        "last_name": last_name,
        "first_name": first_name,
      });
      if (response.statusCode == StatusCodes.CREATED_201) {
        Map<String, dynamic> userData = response.data['data']['item'];
        userModel = UserModel.fromMap(userData);
      }

      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword(
      {required String email, required String new_password}) async {
    try {
      Response response = await dio.patch('/auth/change-password', data: {
        'login': email,
        'new_password': new_password,
      });
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }
}
