import 'package:osonkassa/features/dashboard_views/document/models/document.dart';

abstract class DocumentRepository {
  Future<List<Document>> getDocuments();
}
