import '../models/portal.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class PortalRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  PortalRepository(this.apiService, this.localStorageService);

  Future<Portal> createPortal(Portal portal) async {
    try {
      final data = await apiService.post('portals/create', portal.toJson());
      return Portal.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create portal: ${e.toString()}');
      return portal;
    }
  }

  Future<Portal> getPortal(String id) async {
    final data = await apiService.get('portals/$id');
    return Portal.fromJson(data);
  }

  Future<Portal> updatePortal(String id, Portal portal) async {
    try {
      final data = await apiService.put('portals/$id', portal.toJson());
      return Portal.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update portal: ${e.toString()}');
      portal.status = 'pending_update'; // Assuming 'status' field exists
      return portal;
    }
  }

  Future<void> deletePortal(String id) async {
    await apiService.delete('portals/$id');
  }

  Future<List<Portal>> getAllPortals() async {
    final data = await apiService.get('portals');
    return (data as List).map((item) => Portal.fromJson(item)).toList();
  }

  Future<List<Portal>> getPortalsByVessel(String vesselId) async {
    final data = await apiService.get('portals/vessel/$vesselId');
    return (data as List).map((item) => Portal.fromJson(item)).toList();
  }

  Future<List<String>> getPortalIdsFromServer() async {
    final data = await apiService.get('portals/ids');
    return (data as List).map((item) => item.toString()).toList();
  }
}
