import 'dart:async';

import '../models/sensor.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class SensorRepository {
  final ApiService apiService;

  SensorRepository(this.apiService);

  Future<Sensor> createSensor(Sensor sensor) async {
    try {
      final data = await apiService.post('sensors', sensor.toJson());
      return Sensor.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create sensor: ${e.toString()}');
      return sensor;
    }
  }

  Future<Sensor?> getSensorById(String sensorId) async {
    try {
      final data = await apiService.get('sensors/$sensorId');
      return Sensor.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to get sensor: ${e.toString()}');
      return null; // Return null as a fallback
    }
  }

  Future<List<Sensor>> getAllSensors() async {
    try {
      final data = await apiService.get('sensors');
      return List<Sensor>.from(data.map((x) => Sensor.fromJson(x)));
    } catch (e) {
      SimpleLogger.severe('Failed to get all sensors: ${e.toString()}');
      return [];
    }
  }

  Future<Sensor> updateSensor(String sensorId, Sensor sensor) async {
    try {
      final data = await apiService.put('sensors/$sensorId', sensor.toJson());
      return Sensor.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update sensor: ${e.toString()}');
      return sensor;
    }
  }

  Future<Sensor?> updateBeaconsFound(String sensorId, int beaconsFound) async {
    try {
      final data = await apiService.put(
          'sensors/$sensorId/beacons-found', {'beacons_found': beaconsFound});
      return Sensor.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update beacons found: ${e.toString()}');
      return null;
    }
  }

  Future<Sensor?> updateSensorLocation(
      String sensorId, double locationX, double locationY) async {
    try {
      final data = await apiService.put('sensors/$sensorId/location',
          {'location_x': locationX, 'location_y': locationY});
      return Sensor.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update sensor location: ${e.toString()}');
      return null;
    }
  }
}
