import 'package:flutter/material.dart';
import '../Services/FirebaseAuthService.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  dynamic get currentUser => _authService.currentUser;

  Stream<dynamic> get authStateChanges => _authService.authStateChanges;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await _authService.signInWithEmail(
      email: email,
      password: password,
    );

    _setLoading(false);

    if (result != null) {
      return true;
    } else {
      _errorMessage = _authService.lastError;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await _authService.registerWithEmail(
      email: email,
      password: password,
    );

    _setLoading(false);

    if (result != null) {
      return true;
    } else {
      _errorMessage = _authService.lastError;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    await _authService.signOut();
    _setLoading(false);
  }

  void clearError() => _clearError();

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
