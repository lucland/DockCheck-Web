import '../models/beacon.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class BeaconRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  BeaconRepository(this.apiService, this.localStorageService);

  Future<Beacon> createBeacon(Beacon beacon) async {
    try {
      // Try posting to API
      final data = await apiService.post('beacons/create', beacon.toJson());
      SimpleLogger.info('Beacon created: $data');
      return Beacon.fromJson(data);
    } catch (e) {
      // Log and handle API failure
      SimpleLogger.severe('Beacon creation failed: ${e.toString()}');
      return beacon; // Return the local version
    }
  }

  Future<Beacon> updateBeacon(String id, Beacon beacon) async {
    try {
      final data = await apiService.put('beacons/$id', beacon.toJson());
      SimpleLogger.info('Beacon updated: $data');
      return Beacon.fromJson(data);
    } catch (e) {
      SimpleLogger.severe(
          'Failed to update beacon via API, updating local storage: ${e.toString()}');
      // Mark the beacon as pending update in local storage
      beacon.status = 'pending_update'; // Assuming 'status' field exists
      return beacon; // Return the local version
    }
  }

  Future<void> deleteBeacon(String id) async {
    SimpleLogger.info('Beacon deleted: $id');
    await apiService.delete('beacons/$id');
  }

  Future<Beacon> getBeacon(String id) async {
    final data = await apiService.get('beacons/$id');
    return Beacon.fromJson(data);
  }

  Future<List<Beacon>> getAllBeacons() async {
    try {
      final data = await apiService.get('beacons');
      return (data as List).map((item) => Beacon.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get all beacons: ${e.toString()}');
      // Fetch from local storage as fallback
      // Implement logic to return data from local storage or an empty list
      return []; // Return an empty list as a fallback
    }
  }
}
