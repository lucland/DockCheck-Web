import 'dart:async';

import '../models/area.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class AreaRepository {
  final ApiService apiService;

  AreaRepository(this.apiService);

  Future<Area> createArea(Area area) async {
    try {
      final data = await apiService.post('areas', area.toJson());
      return Area.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create area: ${e.toString()}');
      return area;
    }
  }

  FutureOr<Area> getAreaById(String id) async {
    final data = await apiService.get('areas/$id');
    return Area.fromJson(data);
  }

  Future<List<Area>> getAllAreas() async {
    try {
      final data = await apiService.get('areas');
      return (data as List).map((item) => Area.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get areas: ${e.toString()}');
      return []; // Return an empty list as a fallback
    }
  }

  Future<Area> updateArea(String id, Area area) async {
    try {
      final data = await apiService.put('areas/$id', area.toJson());
      return Area.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update area: ${e.toString()}');
      return area;
    }
  }

  Future<void> deleteArea(String id) async {
    await apiService.delete('areas/$id');
  }
}
