import 'dart:async';

import '../models/authorization.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class AuthorizationRepository {
  final ApiService apiService;

  AuthorizationRepository(this.apiService);

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

  Future<List<Authorization>> getAllAuthorizations() async {
    try {
      final data = await apiService.get('authorizations');
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
      return authorization;
    }
  }

  Future<void> deleteAuthorization(String id) async {
    await apiService.delete('authorizations/$id');
  }

  Future<List<String>> getAllAuthorizationIds() async {
    final data = await apiService.get('authorizations/ids');
    return (data as List).map((item) => item.toString()).toList();
  }

  Future<void> addAuthorizationToEmployee(
      String employeeId, String authorizationId) async {
    try {
      final employee = await apiService.get('employees/$employeeId');
      if (employee == null) {
        SimpleLogger.severe('Employee not found');
        return;
      }
      final currentAuthorizations = employee['authorizations_id'] ?? [];
      final updatedAuthorizations = [...currentAuthorizations, authorizationId];
      employee['authorizations_id'] = updatedAuthorizations;
      await apiService.put('employees/$employeeId', employee);
      SimpleLogger.info('Authorization added to employee successfully');
    } catch (e) {
      SimpleLogger.severe(
          'Error adding authorization to employee: ${e.toString()}');
    }
  }

  Future<void> removeAuthorizationFromEmployee(
      String employeeId, String authorizationId) async {
    try {
      final employee = await apiService.get('employees/$employeeId');
      if (employee == null) {
        SimpleLogger.severe('Employee not found');
        return;
      }
      final currentAuthorizations = employee['authorizations_id'] ?? [];
      final updatedAuthorizations = currentAuthorizations
          .where((authId) => authId != authorizationId)
          .toList();
      employee['authorizations_id'] = updatedAuthorizations;
      await apiService.put('employees/$employeeId', employee);
      SimpleLogger.info('Authorization removed from employee successfully');
    } catch (e) {
      SimpleLogger.severe(
          'Error removing authorization from employee: ${e.toString()}');
    }
  }
}
