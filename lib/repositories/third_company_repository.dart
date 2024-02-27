import 'dart:async';

import '../models/third_company.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class ThirdCompanyRepository {
  final ApiService apiService;

  ThirdCompanyRepository(this.apiService);

  Future<ThirdCompany> createThirdCompany(ThirdCompany thirdCompany) async {
    try {
      final data =
          await apiService.post('third-companies', thirdCompany.toJson());
      return ThirdCompany.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create third company: ${e.toString()}');
      return thirdCompany;
    }
  }

  Future<ThirdCompany?> getThirdCompanyById(String companyId) async {
    try {
      final data = await apiService.get('third-companies/$companyId');
      return ThirdCompany.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to get third company: ${e.toString()}');
      return null; // Return null as a fallback
    }
  }

  Future<List<ThirdCompany>> getAllThirdCompanies() async {
    try {
      final data = await apiService.get('third-companies');
      return List<ThirdCompany>.from(data.map((x) => ThirdCompany.fromJson(x)));
    } catch (e) {
      SimpleLogger.severe('Failed to get all third companies: ${e.toString()}');
      return [];
    }
  }

  Future<ThirdCompany> updateThirdCompany(
      String companyId, ThirdCompany thirdCompany) async {
    try {
      final data = await apiService.put(
          'third-companies/$companyId', thirdCompany.toJson());
      return ThirdCompany.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update third company: ${e.toString()}');
      return thirdCompany;
    }
  }

  Future<void> addAdminToThirdCompany(String companyId, String adminId) async {
    try {
      await apiService
          .post('third-companies/$companyId/admins', {'admin_id': adminId});
      SimpleLogger.info('Admin added successfully');
    } catch (e) {
      SimpleLogger.severe(
          'Failed to add admin to third company: ${e.toString()}');
    }
  }
}
