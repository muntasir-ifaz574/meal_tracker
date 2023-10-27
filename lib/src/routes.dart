import 'package:flutter/material.dart';
import 'package:mealtracker/src/views/ui/add_meal_screen.dart';
import 'package:mealtracker/src/views/ui/auth_screen/sign_in_screen.dart';
import 'package:mealtracker/src/views/ui/auth_screen/sign_up_screen.dart';
import 'package:mealtracker/src/views/ui/edit_meal_screen.dart';
import 'package:mealtracker/src/views/ui/home_screen.dart';
import 'package:mealtracker/src/views/ui/meal_list_screen.dart';
import 'package:mealtracker/src/views/ui/splash_screen.dart';

class Routes {
  Routes._();

  ///--------------Static Variables---------------------///
  static const String splashScreen = '/SplashScreen';
  static const String signInScreen = '/SignInScreen';
  static const String signUpScreen = '/SingUpScreen';
  static const String homeScreen = '/HomeScreen';
  static const String addMealScreen = '/AddMealScreen';
  static const String mealListScreen = '/MealListScreen';
  static const String editMealScreen = '/EditMealScreen';

  ///--------------Routes---------------------///
  static final routes = <String, WidgetBuilder>{
    splashScreen: (BuildContext context) => const SplashScreen(),
    signInScreen: (BuildContext context) => const SignInScreen(),
    signUpScreen: (BuildContext context) => const SingUpScreen(),
    homeScreen: (BuildContext context) => const HomeScreen(),
    addMealScreen: (BuildContext context) => const AddMealScreen(),
    mealListScreen: (BuildContext context) => const MealListScreen(),
    editMealScreen: (BuildContext context) {
      final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      final int mealId = args?['mealId'];
      final String mealType = args?['mealType'];
      final String whatYouEat = args?['whatYouEat'];
      final String totalCalorie = args?['totalCalorie'];

      return EditMealScreen(mealId: mealId, mealType: mealType, whatYouEat: whatYouEat, totalCalorie: totalCalorie,);
    },
  };
}