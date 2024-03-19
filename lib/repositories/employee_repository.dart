import 'dart:async';

import '../models/employee.dart'; // Make sure to import the corresponding model
import '../services/api_service.dart';
import '../utils/simple_logger.dart';

class EmployeeRepository {
  final ApiService apiService;

  EmployeeRepository(this.apiService);

  Future<Employee> createEmployee(Employee employee) async {
    try {
      final data = await apiService.post('employees', employee.toJson());
      return Employee.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create employee: ${e.toString()}');
      return employee;
    }
  }

  Future<void> blockEmployee(String id, String blockReason) async {
    try {
      await apiService
          .post('employees/$id/block', {'block_reason': blockReason});
      SimpleLogger.info('Employee blocked successfully');
    } catch (e) {
      SimpleLogger.severe('Failed to block employee: ${e.toString()}');
    }
  }

  Future<Employee> getEmployeeById(String id) async {
    final data = await apiService.get('employees/$id');
    return Employee.fromJson(data);
  }

  Future<List<Employee>> getAllEmployees() async {
    final data = await apiService.get('employees');
    if (data != null && data is List) {
      print("Data fetched: $data");
      var list = (data).map((item) => Employee.fromJson(item)).toList();
      print("First employee name: ${list.first.name}"); // More detailed log
      return list;
    } else {
      print("Data fetched is null");
      return [];
    }
  }

  //getLastEmployeeNumber
  Future<String> getLastEmployeeNumber() async {
    try {
      final data = await apiService.get('employees/lastnumber');
      print("Data fetched: ${data.toString()}");
      return data['number'];
    } catch (e) {
      SimpleLogger.severe(
          'Failed to get last employee number: ${e.toString()}');
      return '0'; // Return 0 as a fallback
    }
  }

  Future<Employee> updateEmployee(String id, Employee employee) async {
    try {
      final data = await apiService.put('employees/$id', employee.toJson());
      return Employee.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update employee: ${e.toString()}');
      return employee;
    }
  }

  Future<void> updateEmployeeArea(
      String id, String lastAreaFound, DateTime lastTimeFound) async {
    try {
      await apiService.put('employees/$id/area', {
        'last_area_found': lastAreaFound,
        'last_time_found': lastTimeFound.toString()
      });
      SimpleLogger.info('Employee area updated successfully');
    } catch (e) {
      SimpleLogger.severe('Failed to update employee area: ${e.toString()}');
    }
  }
}
