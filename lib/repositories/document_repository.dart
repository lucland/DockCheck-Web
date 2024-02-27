import 'dart:async';

import '../models/document.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class DocumentRepository {
  final ApiService apiService;

  DocumentRepository(this.apiService);

  Future<Document> createDocument(Document document) async {
    try {
      final data = await apiService.post('documents', document.toJson());
      return Document.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create document: ${e.toString()}');
      return document;
    }
  }

  Future<Document> getDocumentById(String id) async {
    final data = await apiService.get('documents/$id');
    return Document.fromJson(data);
  }

  Future<List<Document>> getAllDocuments() async {
    try {
      final data = await apiService.get('documents');
      return (data as List).map((item) => Document.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get documents: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<List<String>> getDocumentIdsByEmployeeId(String employeeId) async {
    try {
      final data = await apiService
          .post('documents/employee', {'employee_id': employeeId});
      return (data as List).map((item) => item.toString()).toList();
    } catch (e) {
      SimpleLogger.severe(
          'Failed to get document IDs by employee ID: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<Document> updateDocument(String id, Document document) async {
    try {
      final data = await apiService.put('documents/$id', document.toJson());
      return Document.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update document: ${e.toString()}');
      return document;
    }
  }

  Future<void> deleteDocument(String id) async {
    await apiService.delete('documents/$id');
  }
}
