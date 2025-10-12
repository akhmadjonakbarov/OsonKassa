import 'package:dio/dio.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../models/customer.dart';

const String _baseUrl = '/customers';

class ClientRepository
    implements
        GetAll<Customer>,
        Add<Map<String, dynamic>>,
        Update<Customer>,
        Delete<int> {
  final Dio dio;

  ClientRepository({required this.dio});

  @override
  Future<List<Customer>> getAll() async {
    try {
      List<Customer> clients = [];
      Response response = await dio.get(
        '$_baseUrl/all',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var client in resData) {
            if (ResponseValidator.isMap(client)) {
              clients.add(Customer.fromJson(client));
            }
          }
        }
      }
      return clients;
    } catch (e) {
      rethrow; // Rethrow the exception to propagate it up the call stack
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      Response response = await dio.delete(
        '$_baseUrl/delete/$id',
      );
      if (response.statusCode == StatusCodes.NOT_FOUND_404) {
        throw DataNotFoundException(message: "Builder not found");
      }
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer?> update(Customer value) async {
    try {
      Map<String, dynamic> builderData = {
        'id': value.id,
        'full_name': value.fullName,
        'phone_number': value.phoneNumber,
        'phone_number2': value.phoneNumber2,
        'address': value.address,
      };

      Response response = await dio.patch(
        '$_baseUrl/update/${value.id}',
        data: builderData,
      );

      if (response.statusCode == StatusCodes.NOT_FOUND_404) {
        throw DataNotFoundException(message: "Builder not found");
      }
      if (response.statusCode == StatusCodes.OK_200) {
        return Customer.fromJson(response.data['data']['item']);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> add(Map<String, dynamic> builderData) async {
    try {
      Response response = await dio.post(
        '$_baseUrl/add',
        data: builderData,
      );

      return response.statusCode == 201;
    } on DioException catch (e) {
      if (e.response!.statusCode == StatusCodes.CONFLICT_409) {
        throw AlreadyExistException(message: "Client already exists");
      } else {
        rethrow;
      }
    }
  }
}
