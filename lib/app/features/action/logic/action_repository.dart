import 'package:dio/dio.dart';
import 'package:osonkassa/app/core/interfaces/api/api_interfaces.dart';
import 'package:osonkassa/app/features/action/models/action_model.dart';

class ActionRepository implements GetAll<ActionModel> {
  final Dio dio;
  ActionRepository({required this.dio});
  static const _baseUrl = '/actions';
  @override
  Future<List<ActionModel>> getAll() async {
    try {
      List<ActionModel> actions = [];
      Response response = await dio.get('$_baseUrl/all');
      if (response.statusCode == 200) {
        var resData = response.data;
        for (var item in resData) {
          actions.add(ActionModel.fromMap(item));
        }
      }
      return actions;
    } catch (e) {
      rethrow;
    }
  }
}
