import 'dart:async';

import '../models/third_project.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class ThirdProjectRepository {
  final ApiService apiService;

  ThirdProjectRepository(this.apiService);

  Future<ThirdProject?> getThirdProjectById(String projectId) async {
    try {
      final data = await apiService.get('third-projects/$projectId');
      return ThirdProject.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to get third project: ${e.toString()}');
      return null; // Return null as a fallback
    }
  }

  Future<List<ThirdProject>> getAllThirdProjects() async {
    try {
      final data = await apiService.get('third-projects');
      return List<ThirdProject>.from(data.map((x) => ThirdProject.fromJson(x)));
    } catch (e) {
      SimpleLogger.severe('Failed to get all third projects: ${e.toString()}');
      return [];
    }
  }

  Future<ThirdProject> updateThirdProject(
      String projectId, ThirdProject thirdProject) async {
    try {
      final data = await apiService.put(
          'third-projects/$projectId', thirdProject.toJson());
      return ThirdProject.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update third project: ${e.toString()}');
      return thirdProject;
    }
  }

  Future<void> addEmployeeToThirdProject(
      String projectId, String employeeId) async {
    try {
      await apiService.post(
          'third-projects/$projectId/employees', {'employee_id': employeeId});
      SimpleLogger.info('Employee added to third project successfully');
    } catch (e) {
      SimpleLogger.severe(
          'Failed to add employee to third project: ${e.toString()}');
    }
  }

  Future<void> updateAllowedAreasOfThirdProject(
      String projectId, List<String> allowedAreasIds) async {
    try {
      await apiService.put('third-projects/$projectId/allowed-areas',
          {'allowed_areas_id': allowedAreasIds});
      SimpleLogger.info('Allowed areas updated successfully');
    } catch (e) {
      SimpleLogger.severe('Failed to update allowed areas: ${e.toString()}');
    }
  }
}
