import 'dart:convert';

import '../models/authorization.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  UserRepository(this.apiService, this.localStorageService);

  Future<User> createUser(User user) async {
    try {
      final data = await apiService.post('users/create', user.toJson());
      //await localStorageService.insertOrUpdate(
      //  'users', User.fromJson(data).toJson(), 'id');
      return User.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create user: ${e.toString()}');
      user.status = 'pending_creation';
      //await localStorageService.insertOrUpdate('users', user.toJson(), 'id');
      return user;
    }
  }

  Future<User> getUser(String id) async {
    final data = await apiService.get('users/$id');
    return User.fromJson(data);
  }

  Future<bool> getValidITag(String itag) async {
    try {
      await apiService.get('users/itag/$itag');
      return true;
    } catch (e) {
      SimpleLogger.severe('iTag not valid: ${e.toString()}');
      return false;
    }
  }

  Future<User> updateUser(String id, User user) async {
    final data = await apiService.put('users/$id', user.toJson());
    return User.fromJson(data);
  }

  Future<void> deleteUser(String id) async {
    await apiService.delete('users/$id');
  }

  Future<List<User>> getAllUsers({int limit = 99, int offset = 0}) async {
    final data = await apiService.get('users?limit=$limit&offset=$offset');
    print(data.toString());
    List<User> usuarios =
        (data as List).map((item) => User.fromJson(item)).toList();
    print(usuarios[0]);

    SimpleLogger.severe('user: ${usuarios[0]}');
    return (data).map((item) => User.fromJson(item)).toList();
  }

  // Get User Authorizations
  Future<List<Authorization>> getUserAuthorizations(String userId) async {
    final data = await apiService.get('users/$userId/authorizations');
    return (data as List).map((item) => Authorization.fromJson(item)).toList();
  }

  // Check Username Availability
  Future<bool> checkUsername(String username) async {
    final data =
        await apiService.post('users/checkUsername', {'username': username});
    return data['message'] == 'Username available';
  }

  // Search Users
  Future<List<User>> searchUsers(String searchTerm,
      {int page = 1, int pageSize = 10}) async {
    const String apiUrl = 'http://172.20.255.223:3000/api/v1/users/search';
    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: {
      'searchTerm': searchTerm,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return (data['users'] as List)
            .map((item) => User.fromJson(item))
            .toList(); // Returns the JSON response as a Map
      } else {
        print('Failed to load users');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // Get Last User Number
  Future<int> getLastUserNumber() async {
    final data = await apiService.get('users/all/lastnumber');
    return int.parse(data.toString());
  }

  // Get Valid Users by Vessel ID
  Future<List<String>> getValidUsersByVesselID(String vesselId) async {
    final data = await apiService.get('users/valids/$vesselId');
    return List<String>.from(data);
  }

  //getUsersIdsFromServer returns a list of user ids
  Future<List<String>> getUsersIdsFromServer() async {
    final data = await apiService.get('users/ids');
    return (data as List).map((item) => item.toString()).toList();
  }

  Future<User> getUserByBeacon(String id) async {
    final data = await apiService.get('users/user/rfid/$id');
    return User.fromJson(data);
  }
}
