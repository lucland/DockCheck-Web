import 'dart:async';

import '../models/beacon.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class BeaconRepository {
  final ApiService apiService;

  BeaconRepository(this.apiService);

  Future<Beacon> createBeacon(Beacon beacon) async {
    try {
      final data = await apiService.post('beacons', beacon.toJson());
      return Beacon.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create beacon: ${e.toString()}');
      return beacon;
    }
  }

  FutureOr<Beacon> getBeaconById(String id) async {
    final data = await apiService.get('beacons/$id');
    return Beacon.fromJson(data);
  }

  Future<List<Beacon>> getAllBeacons() async {
    try {
      final data = await apiService.get('beacons');
      return (data as List).map((item) => Beacon.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get beacons: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<Beacon> updateBeacon(String id, Beacon beacon) async {
    try {
      final data = await apiService.put('beacons/$id', beacon.toJson());
      return Beacon.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update beacon: ${e.toString()}');
      return beacon;
    }
  }

  Future<void> deleteBeacon(String id) async {
    await apiService.delete('beacons/$id');
  }

  Future<void> attachBeacon(String beaconId, String employeeId) async {
    try {
      final beacon = await getBeaconById(beaconId);
      await updateBeacon(
          beaconId,
          Beacon(
            id: beacon.id,
            itag: beacon.itag,
            isValid: true,
            employeeId: employeeId,
            status: beacon.status,
          ));
      SimpleLogger.info('Beacon attached to employee successfully');
    } catch (e) {
      SimpleLogger.severe(
          'Error attaching beacon to employee: ${e.toString()}');
    }
  }

  Future<void> detachBeacon(String beaconId) async {
    try {
      final beacon = await getBeaconById(beaconId);
      await updateBeacon(
          beaconId,
          Beacon(
            id: beacon.id,
            itag: beacon.itag,
            isValid: false,
            employeeId: '',
            status: beacon.status,
          ));
      SimpleLogger.info('Beacon detached from employee successfully');
    } catch (e) {
      SimpleLogger.severe(
          'Error detaching beacon from employee: ${e.toString()}');
    }
  }
}
