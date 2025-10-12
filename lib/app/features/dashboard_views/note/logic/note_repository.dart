import 'package:dio/dio.dart';

import '../../../../core/interfaces/api/get_all.dart';
import '../models/note.dart';

class NoteRepository implements GetAll<Note> {
  final Dio dio;

  NoteRepository({required this.dio});

  static const String baseUrl = '/notes'; // Replace with your API base URL

  @override
  Future<List<Note>> getAll() async {
    try {
      List<Note> spikas = [];
      Response response = await dio.get(
        '$baseUrl/all',
      );

      if (response.statusCode == 200) {
        var resData = response.data['data']['list'];
        for (var provider in resData) {
          spikas.add(Note.fromJson(provider));
        }
      }
      return spikas;
    } catch (e) {
      rethrow;
    }
  }
}
