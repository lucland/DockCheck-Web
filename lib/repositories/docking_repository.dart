import '../models/docking.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class DockingRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  DockingRepository(this.apiService, this.localStorageService);

  Future<Docking> createDocking(Docking docking) async {
    try {
      final data = await apiService.post('dockings/create', docking.toJson());
      return Docking.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create docking: ${e.toString()}');
      return docking;
    }
  }

  Future<Docking> getDocking(String id) async {
    final data = await apiService.get('dockings/$id');
    return Docking.fromJson(data);
  }

  Future<List<Docking>> getAllDockings() async {
    try {
      final data = await apiService.get('dockings');
      return (data as List).map((item) => Docking.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get all dockings: ${e.toString()}');
      // Fetch from local storage as fallback
      // Implement logic to return data from local storage or an empty list
      return []; // Return an empty list as a fallback
    }
  }

  Future<Docking> updateDocking(String id, Docking docking) async {
    try {
      final data = await apiService.put('dockings/$id', docking.toJson());

      return Docking.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update docking: ${e.toString()}');
      docking.status = 'pending_update'; // Assuming 'status' field exists

      return docking;
    }
  }

  Future<void> deleteDocking(String id) async {
    await apiService.delete('dockings/$id');
  }

  Future<List<String>> getDockingIdsFromServer() async {
    final data = await apiService.get('dockings/ids');
    return (data as List).map((item) => item.toString()).toList();
  }
}
