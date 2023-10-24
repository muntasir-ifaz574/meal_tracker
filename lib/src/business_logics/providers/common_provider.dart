import 'package:flutter/material.dart';
import 'package:mealtracker/src/business_logics/models/delete_meal_response.dart';
import 'package:mealtracker/src/business_logics/models/meal_list_response_model.dart';
import '../../services/repository.dart';
import '../models/add_meal_response_model.dart';
import '../models/error_response_model.dart';

class CommonProvider extends ChangeNotifier {

  bool _inProgress = false, _isError = false,_isDelete = false;
  ErrorResponseModel? _errorResponse;
  AddMealResponseModel? _addMealResponseModel;
  MealListResponseModel? _mealListResponseModel;
  DeleteMealResponseModel? _deleteMealResponseModel;


  bool get inProgress => _inProgress;
  bool get isError => _isError;
  bool get isDelete => _isDelete;

  ErrorResponseModel? get errorResponse => _errorResponse;
  AddMealResponseModel? get addMealResponseModel => _addMealResponseModel;
  MealListResponseModel? get mealListResponseModel => _mealListResponseModel;
  DeleteMealResponseModel? get deleteMealResponseModel => _deleteMealResponseModel;


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

  ///------------------Meal List Provider--------------------------///
  Future<bool> mealListProvider() async {
    _inProgress = true;
    _mealListResponseModel = null;
    notifyListeners();
    final response = await repository.mealListProvider();
    if (response.id == 200) {
      _inProgress = false;
      _mealListResponseModel = response.object as MealListResponseModel;
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

  ///------------------Delete Meal Provider--------------------------///
  Future<bool> deleteMealProvider({required int id}) async {
    _isDelete = true;
    _deleteMealResponseModel = null;
    notifyListeners();
    final response = await repository.deleteMealProvider(id: id);
    if (response.id == 200) {
      _isDelete = false;
      _deleteMealResponseModel = response.object as DeleteMealResponseModel;
      notifyListeners();
      return true;
    } else {
      _isDelete = false;
      _isError = true;
      _errorResponse = response.object as ErrorResponseModel;
      notifyListeners();
      return false;
    }
  }

}