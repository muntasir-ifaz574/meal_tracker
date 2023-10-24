import 'package:mealtracker/src/services/api_services/common_api_services.dart';

import '../business_logics/models/api_response_object.dart';
import 'api_services/auth_api_services.dart';


final repository = _Repository();

class _Repository {
  final AuthAPIServices _authAPIServices = AuthAPIServices();
  final CommonAPIServices _commonAPIServices = CommonAPIServices();

  ///--------------------------Auth Repository-------------------///
  Future<ResponseObject> signInProvider({required String email, required String password}) => _authAPIServices.signInAPI(email: email, password: password);
  Future<ResponseObject> signUpProvider({required String username,required String email, required String password}) => _authAPIServices.signUpAPI(username: username,email: email, password: password);

  ///--------------------------Common Repository-------------------///
  Future<ResponseObject> addMealProvider({required String mealType, required String whatYouEat, required String totalCalorie}) => _commonAPIServices.addMealAPI(mealType: mealType,whatYouEat: whatYouEat,totalCalorie: totalCalorie);


}
