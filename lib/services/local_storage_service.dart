import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/user.dart';
import '../utils/simple_logger.dart';

class LocalStorageService {
  // Initialize Hive
  Future<void> init() async {
    Hive.init('./');
    SimpleLogger.info("Initializing Local Storage Service with Hive");
  }

  Future<void> saveToken(String token) async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Saving token: $token");
    await box.put('jwt_token', token);
    await box.close();
  }

  Future<void> deleteToken() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Deleting token");
    await box.delete('jwt_token');
    await box.close();
  }

  Future<String?> getToken() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Getting token");
    String? token = box.get('jwt_token');
    await box.close();
    return token;
  }

  Future<void> saveVesselId(String vesselId) async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Saving vesselId: $vesselId");
    await box.put('vessel_id', vesselId);
    await box.close();
  }

  Future<void> deleteVesselId() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Deleting vesselId");
    await box.delete('vessel_id');
    await box.close();
  }

  Future<String?> getVesselId() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Getting vesselId");
    String? vesselId = box.get('vessel_id');
    await box.close();
    return vesselId;
  }

  Future<void> saveUserId(String userId) async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Saving userId: $userId");
    await box.put('user_id', userId);
    await box.close();
  }

  Future<void> deleteUserId() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Deleting userId");
    await box.delete('user_id');
    await box.close();
  }

  Future<String?> getUserId() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Getting userId");
    String? userId = box.get('user_id');
    await box.close();
    return userId;
  }

  Future<void> saveUsername(String username) async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Saving username: $username");
    await box.put('username', username);
    await box.close();
  }

  Future<void> deleteUsername() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Deleting username");
    await box.delete('username');
    await box.close();
  }

  Future<String?> getUsername() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Getting username");
    String? username = box.get('username');
    await box.close();
    return username;
  }

  Future<void> saveUser(User user) async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Saving user: ${user.toJson()}");
    await box.put('user', jsonEncode(user.toJson()));
    await box.close();
  }

  Future<void> deleteUser() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Deleting user");
    await box.delete('user');
    await box.close();
  }

  Future<User?> getUser() async {
    var box = await Hive.openBox('secureBox');
    SimpleLogger.info("Getting user");
    String? userString = box.get('user');
    await box.close();
    if (userString != null) {
      return User.fromJson(jsonDecode(userString));
    } else {
      return null;
    }
  }
}
