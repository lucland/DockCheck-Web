import 'dart:async';

import '../models/authorization.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class AuthorizationRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  AuthorizationRepository(this.apiService, this.localStorageService);

  Future<Authorization> createAuthorization(Authorization authorization) async {
    try {
      final data =
          await apiService.post('authorizations', authorization.toJson());
      return Authorization.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create authorization: ${e.toString()}');
      return authorization;
    }
  }

  FutureOr<Authorization> getAuthorizationById(String id) async {
    final data = await apiService.get('authorizations/$id');
    return Authorization.fromJson(data);
  }

  Future<List<Authorization>> getAuthorizations(String userId) async {
    try {
      final data = await apiService.get('authorizations/user/$userId');
      SimpleLogger.info(data.toString());
      return (data as List)
          .map((item) => Authorization.fromJson(item))
          .toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get authorizations: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<Authorization> updateAuthorization(
      String id, Authorization authorization) async {
    try {
      final data =
          await apiService.put('authorizations/$id', authorization.toJson());
      return Authorization.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update authorization: ${e.toString()}');
      authorization.status = 'pending_update'; // Assuming 'status' field exists
      return authorization;
    }
  }

  Future<void> deleteAuthorization(String id) async {
    await apiService.delete('authorizations/$id');
  }

  Future<List<Authorization>> getAuthorizationsFromServer() async {
    final data = await apiService.get('authorizations');
    return (data as List).map((item) => Authorization.fromJson(item)).toList();
  }

  //getAuthorizationIdsFromServer returns a list of authorization ids
  Future<List<String>> getAuthorizationIdsFromServer() async {
    final data = await apiService.get('authorizations/ids');
    return (data as List).map((item) => item.toString()).toList();
  }
}
