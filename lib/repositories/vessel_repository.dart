import '../models/vessel.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class VesselRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  VesselRepository(this.apiService, this.localStorageService);

  Future<Vessel> getVessel(String id) async {
    final data = await apiService.get('vessels/$id');
    SimpleLogger.info('Vessel: $data');
    return Vessel.fromJson(data);
  }

  Future<List<Vessel>> getVesselsByName(String name) async {
    try {
      final data = await apiService.get('vessels/name/$name');
      return (data as List).map((item) => Vessel.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get vessels by name: ${e.toString()}');
      return [];
    }
  }

  Future<Vessel> updateVessel(String id, Vessel vessel) async {
    try {
      final data = await apiService.put('vessels/$id', vessel.toJson());
      return Vessel.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update vessel: ${e.toString()}');
      vessel.status = 'pending_update';
      return vessel;
    }
  }

  Future<void> deleteVessel(String id) async {
    try {
      await apiService.delete('vessels/$id');
    } catch (e) {
      SimpleLogger.severe('Failed to delete vessel: ${e.toString()}');
      // Handle deletion failure
    }
  }

  Future<List<Vessel>> getVesselsByCompany(String companyId) async {
    try {
      final data = await apiService.get('vessels/company/$companyId');
      return (data as List).map((item) => Vessel.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get vessels by company: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<List<Vessel>> getAllVessels() async {
    try {
      final data = await apiService.get('vessels');
      return (data as List).map((item) => Vessel.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get all vessels: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  //get onboarded users of a vessel with /vessels/onboarded/{id}/
  Future<List<String>> getOnboardedUsers(String id) async {
    final data = await apiService.get('vessels/onboarded/$id');
    return (data as List).map((item) => item.toString()).toList();
  }

  Future<Vessel> createVessel(Vessel vessel) async {
    try {
      final data = await apiService.post('vessels/create', vessel.toJson());
      return Vessel.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create vessel: ${e.toString()}');
      vessel.status = 'pending_creation'; // Assuming 'status' field exists
      return vessel;
    }
  }

  Future<List<String>> getAllVesselsIdsFromServer() async {
    final data = await apiService.get('vessels/ids');
    return (data as List).map((item) => item.toString()).toList();
  }
}
