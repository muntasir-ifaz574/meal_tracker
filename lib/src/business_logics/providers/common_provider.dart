import 'package:flutter/material.dart';
import 'package:mealtracker/src/business_logics/models/delete_meal_response.dart';
import 'package:mealtracker/src/business_logics/models/edit_meal_response_model.dart';
import 'package:mealtracker/src/business_logics/models/meal_list_response_model.dart';
import '../../services/repository.dart';
import '../models/add_meal_response_model.dart';
import '../models/error_response_model.dart';

class CommonProvider extends ChangeNotifier {

  bool _inProgress = false, _isError = false,_isDelete = false;
  List<bool> mealItemLoadingStates = [];
  ErrorResponseModel? _errorResponse;
  AddMealResponseModel? _addMealResponseModel;
  EditMealResponseModel? _editMealResponseModel;
  MealListResponseModel? _mealListResponseModel;
  DeleteMealResponseModel? _deleteMealResponseModel;


  bool get inProgress => _inProgress;
  bool get isError => _isError;
  bool get isDelete => _isDelete;

  ErrorResponseModel? get errorResponse => _errorResponse;
  AddMealResponseModel? get addMealResponseModel => _addMealResponseModel;
  EditMealResponseModel? get editMealResponseModel => _editMealResponseModel;
  MealListResponseModel? get mealListResponseModel => _mealListResponseModel;
  DeleteMealResponseModel? get deleteMealResponseModel => _deleteMealResponseModel;


  ///------------------Add Meal Provider--------------------------///
  Future<bool> addMealProvider({required String mealType, required String whatYouEat, required String totalCalorie,required String time}) async {
    _inProgress = true;
    _addMealResponseModel = null;
    notifyListeners();
    final response = await repository.addMealProvider(mealType: mealType,whatYouEat: whatYouEat,totalCalorie: totalCalorie,time: time);
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

  ///------------------Edit Meal Provider--------------------------///
  Future<bool> editMealProvider({required int id,required String mealType, required String whatYouEat, required String totalCalorie}) async {
    _inProgress = true;
    _editMealResponseModel = null;
    notifyListeners();
    final response = await repository.editMealProvider(id: id,mealType: mealType,whatYouEat: whatYouEat,totalCalorie: totalCalorie);
    if (response.id == 200) {
      _inProgress = false;
      _editMealResponseModel = response.object as EditMealResponseModel;
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
      mealItemLoadingStates = List.filled(mealListResponseModel?.data?.length ?? 0, false);
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
  Future<bool> deleteMealProvider({required int id,required int index}) async {
    mealItemLoadingStates[index] = true;
    notifyListeners();
    _isDelete = true;
    _deleteMealResponseModel = null;
    mealItemLoadingStates[index] = true;
    notifyListeners();
    final response = await repository.deleteMealProvider(id: id);
    mealItemLoadingStates[index] = false;
    notifyListeners();
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