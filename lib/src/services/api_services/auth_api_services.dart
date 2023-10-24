import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mealtracker/src/business_logics/models/sign_in_response_model.dart';
import 'package:mealtracker/src/business_logics/models/sign_up_response_model.dart';
import '../../business_logics/models/api_response_object.dart';
import '../../business_logics/models/error_response_model.dart';
import '../../business_logics/models/user_data_model.dart';
import '../../business_logics/utils/constants.dart';
import '../../business_logics/utils/log_debugger.dart';
import '../shared_preference_services/shared_prefs_services.dart';


class AuthAPIServices {

  final Logger _logger = Logger();

  ///------------------Shared Preference--------------------------///
  saveUserData(SignInResponseModel signInResponseModel) {
    if(signInResponseModel.accessToken != null) {
      SharedPrefsServices.setStringData("accessToken", signInResponseModel.accessToken as String);
      UserData.accessToken = signInResponseModel.accessToken;
    }

    SharedPrefsServices.setIntegerData("id", signInResponseModel.user?.id ?? 0);
    SharedPrefsServices.setStringData("name", signInResponseModel.user?.name ?? "");
    SharedPrefsServices.setStringData("email", signInResponseModel.user?.email ?? "");


    UserData.id = signInResponseModel.user?.id;
    UserData.name = signInResponseModel.user?.name;
    UserData.email = signInResponseModel.user?.email;

  }

  ///------------------Sign In API Service--------------------------///
  Future<ResponseObject> signInAPI({required String email, required String password}) async {
    try {
      Uri uri = Uri.parse('$BASE_URL/auth/login');
      final request = http.Request("POST", uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      request.body = jsonEncode({
        'email': email,
        'password': password
      });

      LogDebugger.instance.i(request.body);

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();
      final decodedJson = json.decode(responseData);
      _logger.v('decoded: $decodedJson');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var signInResponseModel = SignInResponseModel.fromJson(decodedJson);
        saveUserData(signInResponseModel);
        return ResponseObject(id: 200, object: signInResponseModel);
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

  ///------------------Sign In API Service--------------------------///
  Future<ResponseObject> signUpAPI({required String username,required String email,required String password}) async {
    try {
      Uri uri = Uri.parse('$BASE_URL/auth/register');
      final request = http.Request("POST", uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      request.body = jsonEncode({
        'name': username,
        'email': email,
        'password': password
      });

      LogDebugger.instance.i(request.body);

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();
      final decodedJson = json.decode(responseData);
      _logger.v('decoded: $decodedJson');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var signUpResponse = SignUpResponseModel.fromJson(decodedJson);

        return ResponseObject(id: 200, object: signUpResponse);
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
