import 'dart:convert';

import 'package:get/get.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/global_functions.dart';

class UserManager {
  UserManager._internal();

  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  // SharedPreferences instance
  SharedPreferences? _preferences;

  ///save user to shared preference key
  static const String _userKey = 'user';

  ///check if the app is opening for first time
  static const String _firstOpen = 'firstOpen';
  static const String _firstTimeAddSongScreen = 'firstTimeAddSongScreen';
  final RxBool _isFirstOpen = false.obs;
  final RxBool _isFirstTimeAddSongScreen = false.obs;

  bool get isFirstOpen => _isFirstOpen.value;

  bool get isFirstTimeAddSongScreen => _isFirstTimeAddSongScreen.value;

  // In-memory cache of the company model
  final Rxn<UserModel> _cachedUserModel = Rxn<UserModel>();

  ///get current user
  UserModel? get cachedUser => _cachedUserModel.value;

  ///get obx user
  Rxn<UserModel> get obsUser => _cachedUserModel;

  String? get userApiToken => _cachedUserModel.value?.token;

  set cachedUser(UserModel? user) {
    _cachedUserModel.value = user;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    await getCurrentUser(); // Load cached data during initialization
    await checkFirstOpen();

    // Listen for changes to _cachedUserModel and persist changes
    ever<UserModel?>(_cachedUserModel, (user) async {
      if (user != null) {
        // Automatically save changes to SharedPreferences when the model updates
        await saveUser(user);
      }
    });
  }

  /// Get the current user model from SharedPreferences
  Future<UserModel?> getCurrentUser() async {
    if (_cachedUserModel.value != null) return _cachedUserModel.value;

    final jsonString = _preferences?.getString(_userKey);

    customPrint("\n[getCurrentUser]\n$jsonString\n");
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      if (jsonMap['id'] == -1) {
        await clearUser();
      } else {
        _cachedUserModel.value = UserModel.fromJson(jsonMap);
      }
    }
    return _cachedUserModel.value;
  }

  ///save user
  Future<void> saveUser(UserModel userModel) async {
    var data = userModel.toSharedJson();

    customPrint("\n[saveUser]\n$data\n");

    ///save data to shared preference
    await _preferences?.setString(_userKey, jsonEncode(data));
  }

  /// Clear the current user model from SharedPreferences and cache
  Future<void> clearUser() async {
    _cachedUserModel.value = null; // Clear in-memory cache
    await _preferences?.remove(_userKey);
  }

  Future<void> updateFirstTimeAddSongScreen() async {
    _isFirstTimeAddSongScreen.value = false;
    await _preferences?.setBool(_firstTimeAddSongScreen, false);
  }

  Future<void> checkFirstOpen() async {
    _isFirstOpen.value = _preferences?.getBool(_firstOpen) ?? false;
    _isFirstTimeAddSongScreen.value =
        _preferences?.getBool(_firstTimeAddSongScreen) ?? true;

    ///update shared preference
    await _preferences?.setBool(_firstOpen, false);
  }

  Future<void> saveFirstTimeAddSongScreen() async {
    _isFirstTimeAddSongScreen.value = false;
    await _preferences?.setBool(_firstTimeAddSongScreen, false);
  }
}
