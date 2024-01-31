import '../models/company.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class CompanyRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  CompanyRepository(this.apiService, this.localStorageService);

  Future<Company> createCompany(Company company) async {
    try {
      final data = await apiService.post('companies/create', company.toJson());
      return Company.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create company: ${e.toString()}');
      return company;
    }
  }

  Future<Company> getCompany(String id) async {
    final data = await apiService.get('companies/$id');
    return Company.fromJson(data);
  }

  Future<List<Company>> getAllCompanies() async {
    try {
      final data = await apiService.get('companies');
      return (data as List).map((item) => Company.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get all companies: ${e.toString()}');
      // Fetch from local storage as fallback
      // Implement logic to return data from local storage or an empty list
      return []; // Return an empty list as a fallback
    }
  }

  Future<Company> updateCompany(String id, Company company) async {
    try {
      final data = await apiService.put('companies/$id', company.toJson());
      return Company.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update company: ${e.toString()}');
      company.status = 'pending_update'; // Assuming 'status' field exists
      return company;
    }
  }

  Future<void> deleteCompany(String id) async {
    await apiService.delete('companies/$id');
  }

  //get all companies ids from server with /companies/ids
  Future<List<String>> getCompanyIdsFromServer() async {
    final data = await apiService.get('companies/ids');
    return (data as List).map((item) => item.toString()).toList();
  }
}
