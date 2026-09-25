import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../models/user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<void> checkAuthSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return;
    }

    try {
      final response = await _apiClient.dio.get(ApiConstants.me);
      _user = UserModel.fromJson(response.data['data']['user']);
      _status = AuthStatus.authenticated;
    } catch (_) {
      await prefs.remove('auth_token');
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiClient.dio.post(ApiConstants.signup, data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      });

      final data = response.data['data'];
      final token = data['token'];
      _user = UserModel.fromJson(data['user']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      if (e is DioException) {
        _errorMessage = e.error?.toString() ?? e.response?.data?['message'] ?? e.message ?? 'Sign up failed. Please try again.';
      } else {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      }
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiClient.dio.post(ApiConstants.login, data: {
        'email': email,
        'password': password,
      });

      final data = response.data['data'];
      final token = data['token'];
      _user = UserModel.fromJson(data['user']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      if (e is DioException) {
        _errorMessage = e.error?.toString() ?? e.response?.data?['message'] ?? e.message ?? 'Login failed. Please check your credentials or network.';
      } else {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      }
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
