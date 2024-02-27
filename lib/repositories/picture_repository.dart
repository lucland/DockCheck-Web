import 'dart:async';

import '../models/picture.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class PictureRepository {
  final ApiService apiService;

  PictureRepository(this.apiService);

  Future<Picture> createEmployeePicture(Picture picture) async {
    try {
      final data = await apiService.post('pictures', picture.toJson());
      return Picture.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create picture: ${e.toString()}');
      return picture;
    }
  }

  Future<Picture?> getPictureByEmployeeId(String employeeId) async {
    try {
      final data = await apiService.get('pictures/employee/$employeeId');
      return Picture.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to get picture: ${e.toString()}');
      return null; // Return null as a fallback
    }
  }

  Future<Picture> updatePicture(String id, Picture picture) async {
    try {
      final data = await apiService.put('pictures/$id', {'pic': picture});
      return Picture.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update picture: ${e.toString()}');
      return picture;
    }
  }

  Future<bool> deletePicture(String id) async {
    try {
      final data = await apiService.delete('pictures/$id');
      return data['message'] == 'Picture deleted successfully';
    } catch (e) {
      SimpleLogger.severe('Failed to delete picture: ${e.toString()}');
      return false;
    }
  }
}
