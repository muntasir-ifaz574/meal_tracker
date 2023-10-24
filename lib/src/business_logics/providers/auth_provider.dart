import 'package:flutter/material.dart';
import 'package:mealtracker/src/business_logics/models/sign_in_response_model.dart';
import '../../services/repository.dart';
import '../models/error_response_model.dart';
import '../models/sign_up_response_model.dart';

class AuthProvider extends ChangeNotifier {

  bool _inProgress = false, _isError = false;
  ErrorResponseModel? _errorResponse;
  SignInResponseModel? _signInResponseModel;
  SignUpResponseModel? _signUpResponseModel;

  bool get inProgress => _inProgress;
  bool get isError => _isError;

  ErrorResponseModel? get errorResponse => _errorResponse;
  SignInResponseModel? get signInResponse => _signInResponseModel;
  SignUpResponseModel? get signUpResponseModel => _signUpResponseModel;

  ///------------------Sign In Provider--------------------------///
  Future<bool> signInProvider({required String email, required String password}) async {
    _inProgress = true;
    _signInResponseModel = null;
    notifyListeners();
    final response = await repository.signInProvider(email: email, password: password);
    if (response.id == 200) {
      _inProgress = false;
      _signInResponseModel = response.object as SignInResponseModel;
      notifyListeners();
      return true;
    } else {
      _inProgress = false;
      _isError = true;
      _errorResponse = response.object as ErrorResponseModel;
      notifyListeners();
      return false;
    }
  }

  ///------------------Sign Up Provider--------------------------///
  Future<bool> signUpProvider({required String username,required String email, required String password}) async {
    _inProgress = true;
    _signUpResponseModel = null;
    notifyListeners();
    final response = await repository.signUpProvider(username: username,email: email, password: password);
    if (response.id == 200) {
      _inProgress = false;
      _signUpResponseModel = response.object as SignUpResponseModel;
      notifyListeners();
      return true;
    } else {
      _inProgress = false;
      _isError = true;
      _errorResponse = response.object as ErrorResponseModel;
      notifyListeners();
      return false;
    }
  }

}