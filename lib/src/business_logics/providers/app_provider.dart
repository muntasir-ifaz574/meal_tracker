import 'package:flutter/material.dart';
import '../models/error_response_model.dart';

class AppProvider extends ChangeNotifier {

  int _selectedBottomNavIndex = 0;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;
  setBottomNavIndex(value) {
    _selectedBottomNavIndex = value;
    notifyListeners();
  }

  bool _isError = false;

  bool get isError => _isError;

  ErrorResponseModel? _errorResponse;

  ErrorResponseModel? get errorResponse => _errorResponse;
}