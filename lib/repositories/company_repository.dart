import 'dart:async';

import '../models/company.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class CompanyRepository {
  final ApiService apiService;

  CompanyRepository(this.apiService);

  Future<Company> createCompany(Company company) async {
    try {
      final data = await apiService.post('companies', company.toJson());
      return Company.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create company: ${e.toString()}');
      return company;
    }
  }

  FutureOr<Company> getCompanyById(String id) async {
    final data = await apiService.get('companies/$id');
    return Company.fromJson(data);
  }

  Future<List<Company>> getAllCompanies() async {
    try {
      final data = await apiService.get('companies');
      return (data as List).map((item) => Company.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get companies: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<Company> updateCompany(String id, Company company) async {
    try {
      final data = await apiService.put('companies/$id', company.toJson());
      return Company.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update company: ${e.toString()}');
      return company;
    }
  }

  Future<void> deleteCompany(String id) async {
    await apiService.delete('companies/$id');
  }

  Future<List<String>> getAllCompanyIds() async {
    try {
      final data = await apiService.get('companies/ids');
      return (data as List).map((item) => item.toString()).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get company ids: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }
}
