import '../../../core/interfaces/api/api_interfaces.dart';
import '../models/report_model.dart';

class ReportService {
  final GetAll<ReportModel> _getAllRepository;

  ReportService({required GetAll<ReportModel> getAllRepository})
      : _getAllRepository = getAllRepository;

  Future<List<ReportModel>> getAllReports() async {
    try {
      return await _getAllRepository.getAll();
    } catch (error) {
      rethrow;
    }
  }
}
