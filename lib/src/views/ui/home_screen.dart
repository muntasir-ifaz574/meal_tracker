import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mealtracker/src/business_logics/models/user_data_model.dart';
import 'package:mealtracker/src/views/utils/colors.dart';
import 'package:mealtracker/src/views/widgets/home_screen_custom_continer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes.dart';
import '../../services/shared_preference_services/shared_prefs_services.dart';
import '../utils/custom_text_style.dart';
import '../widgets/custom_warning_message_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${UserData.name}",
                      style: kHLargeTitleTextStyle,
                    ),
                    IconButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await SharedPrefsServices.setStringData('accessToken', '');
                        prefs.setBool('hasCheckedIn', false);
                        customWidget.showCustomSnackBar(context, "Successfully Sign Out");
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.signInScreen,
                            (route) => false);
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: kBlackColor,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                  child: Lottie.asset('assets/lotties/home_screen_lottie.json'),
                ),
                SizedBox(height: 5.h),
                const Text(
                  "Meal Tracker",
                  style: kHTitleTextStyle,
                ),
                const Text(
                  "Your Daily Food Journal",
                  style: TextStyle(
                    color: kThemeColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    homeScreenCustomContainer(
                      "assets/lotties/add_meal_lottie.json",
                      "Add Meal",
                      () {
                        Navigator.pushNamed(
                          context,
                          Routes.addMealScreen,
                        );
                      },
                    ),
                    homeScreenCustomContainer(
                      "assets/lotties/meal_list_lottie.json",
                      "Meal List",
                      () {
                        Navigator.pushNamed(
                          context,
                          Routes.mealListScreen,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
