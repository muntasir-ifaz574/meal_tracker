import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:mealtracker/src/business_logics/models/add_meal_response_model.dart';
import 'package:mealtracker/src/business_logics/models/edit_meal_response_model.dart';
import 'package:mealtracker/src/business_logics/models/meal_list_response_model.dart';
import '../../business_logics/models/api_response_object.dart';
import '../../business_logics/models/delete_meal_response.dart';
import '../../business_logics/models/error_response_model.dart';
import '../../business_logics/models/user_data_model.dart';
import '../../business_logics/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../../business_logics/utils/log_debugger.dart';

class CommonAPIServices {

  final Logger _logger = Logger();

  ///------------------Add Meal API Service--------------------------///
  Future<ResponseObject> addMealAPI({required String mealType, required String whatYouEat, required String totalCalorie, required String time}) async {
    try {
      Uri uri = Uri.parse('$BASE_URL/auth/meals');
      final request = http.Request("POST", uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${UserData.accessToken}';

      request.body = jsonEncode({
        "type" : mealType,
        "name" : whatYouEat,
        "calories" : totalCalorie,
        "time" : time,
      });

      LogDebugger.instance.i(request.body);

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();
      final decodedJson = json.decode(responseData);
      _logger.v('decoded: $decodedJson');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var addMealResponseModel = AddMealResponseModel.fromJson(decodedJson);

        return ResponseObject(id: 200, object: addMealResponseModel);
      } else {
        return ResponseObject(
            id: response.statusCode,
            object: ErrorResponseModel.fromJson(decodedJson));
      }
    } catch (e) {
      _logger.v(e.toString());
      return ResponseObject(id: 500, object: ErrorResponseModel());
    }
  }

  ///------------------Edit Meal API Service--------------------------///
  Future<ResponseObject> editMealAPI({required int id,required String mealType, required String whatYouEat, required String totalCalorie}) async {
    try {
      Uri uri = Uri.parse('$BASE_URL/auth/meals/$id');
      final request = http.Request("POST", uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${UserData.accessToken}';

      request.body = jsonEncode({
        "type" : mealType,
        "name" : whatYouEat,
        "calories" : totalCalorie
      });

      LogDebugger.instance.i(request.body);

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();
      final decodedJson = json.decode(responseData);
      _logger.v('decoded: $decodedJson');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var editMealResponseModel = EditMealResponseModel.fromJson(decodedJson);

        return ResponseObject(id: 200, object: editMealResponseModel);
      } else {
        return ResponseObject(
            id: response.statusCode,
            object: ErrorResponseModel.fromJson(decodedJson));
      }
    } catch (e) {
      _logger.v(e.toString());
      return ResponseObject(id: 500, object: ErrorResponseModel());
    }
  }

  ///------------------Meal List API Service--------------------------///
  Future<ResponseObject> mealListAPI() async {
    try {
      Uri uri = Uri.parse('$BASE_URL/auth/meals');
      final request = http.Request("GET", uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${UserData.accessToken}';

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();
      final decodedJson = json.decode(responseData);
      _logger.v('decoded: $decodedJson');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var mealListResponseModel = MealListResponseModel.fromJson(decodedJson);

        return ResponseObject(id: 200, object: mealListResponseModel);
      } else {
        return ResponseObject(
            id: response.statusCode,
            object: ErrorResponseModel.fromJson(decodedJson));
      }
    } catch (e) {
      _logger.v(e.toString());
      return ResponseObject(id: 500, object: ErrorResponseModel());
    }
  }

  ///------------------Delete Meal API Service--------------------------///
  Future<ResponseObject> deleteMealAPI({required int id}) async {
    try {
      Uri uri = Uri.parse('$BASE_URL/auth/meals-delete/$id');
      final request = http.Request("POST", uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${UserData.accessToken}';


      LogDebugger.instance.i(request.body);

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();
      final decodedJson = json.decode(responseData);
      _logger.v('decoded: $decodedJson');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var deleteMealResponseModel = DeleteMealResponseModel.fromJson(decodedJson);
        return ResponseObject(id: 200, object: deleteMealResponseModel);
      } else {
        return ResponseObject(
            id: response.statusCode,
            object: ErrorResponseModel.fromJson(decodedJson));
      }
    } catch (e) {
      _logger.v(e.toString());
      return ResponseObject(id: 500, object: ErrorResponseModel());
    }
  }

}