import 'dart:async';

import '../models/vessel.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class VesselRepository {
  final ApiService apiService;

  VesselRepository(this.apiService);

  Future<Vessel?> createVessel(Map<String, dynamic> vesselData) async {
    try {
      final data = await apiService.post('vessels', vesselData);
      return Vessel.fromJson(data['vessel']);
    } catch (e) {
      SimpleLogger.severe('Failed to create vessel: ${e.toString()}');
      return null; // Return null as a fallback
    }
  }

  Future<Vessel?> getVesselById(String vesselId) async {
    try {
      final data = await apiService.get('vessels/$vesselId');
      return Vessel.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to get vessel: ${e.toString()}');
      return null;
    }
  }

  Future<Vessel?> updateVessel(
      String vesselId, Map<String, dynamic> updateData) async {
    try {
      final data = await apiService.put('vessels/$vesselId', updateData);
      return Vessel.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update vessel: ${e.toString()}');
      return null;
    }
  }

  Future<void> deleteVessel(String vesselId) async {
    try {
      await apiService.delete('vessels/$vesselId');
      SimpleLogger.info('Vessel deleted successfully');
    } catch (e) {
      SimpleLogger.severe('Failed to delete vessel: ${e.toString()}');
    }
  }

  Future<List<Vessel>> getVesselsByCompany(String companyId) async {
    try {
      final data = await apiService.get('vessels/company/$companyId');
      return List<Vessel>.from(data.map((x) => Vessel.fromJson(x)));
    } catch (e) {
      SimpleLogger.severe('Failed to get vessels by company: ${e.toString()}');
      return [];
    }
  }

  Future<List<Vessel>> getAllVessels() async {
    try {
      final data = await apiService.get('vessels');
      return List<Vessel>.from(data.map((x) => Vessel.fromJson(x)));
    } catch (e) {
      SimpleLogger.severe('Failed to get all vessels: ${e.toString()}');
      return [];
    }
  }
}
