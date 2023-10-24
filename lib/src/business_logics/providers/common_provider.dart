import 'package:flutter/material.dart';
import '../../services/repository.dart';
import '../models/add_meal_response_model.dart';
import '../models/error_response_model.dart';

class CommonProvider extends ChangeNotifier {

  bool _inProgress = false, _isError = false;
  ErrorResponseModel? _errorResponse;
  AddMealResponseModel? _addMealResponseModel;


  bool get inProgress => _inProgress;
  bool get isError => _isError;

  ErrorResponseModel? get errorResponse => _errorResponse;
  AddMealResponseModel? get addMealResponseModel => _addMealResponseModel;


  ///------------------Add Meal Provider--------------------------///
  Future<bool> addMealProvider({required String mealType, required String whatYouEat, required String totalCalorie}) async {
    _inProgress = true;
    _addMealResponseModel = null;
    notifyListeners();
    final response = await repository.addMealProvider(mealType: mealType,whatYouEat: whatYouEat,totalCalorie: totalCalorie);
    if (response.id == 200) {
      _inProgress = false;
      _addMealResponseModel = response.object as AddMealResponseModel;
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