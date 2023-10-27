import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mealtracker/src/views/utils/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../business_logics/models/user_data_model.dart';
import '../../routes.dart';
import '../../services/shared_preference_services/shared_prefs_services.dart';
import '../utils/animation/delayed_animation.dart';
import '../widgets/custome_image.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int duration = 2;
  bool? userLoggedIn;


  @override
  void initState() {
    getUserAuthState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    checkState(context);
    super.initState();
  }


  getUserAuthState() {
    UserData.accessToken = SharedPrefsServices.getStringData("accessToken");
    UserData.id = SharedPrefsServices.getIntData("id");
    UserData.name = SharedPrefsServices.getStringData("name");
    UserData.email = SharedPrefsServices.getStringData("email");
    userLoggedIn = (UserData.accessToken ?? "") != "";
  }


  checkState(context) {
    Timer(Duration(seconds: duration), () {
      userLoggedIn == null ? checkState(context)
          : Navigator.pushNamedAndRemoveUntil(
          context,
          userLoggedIn!
            ? Routes.homeScreen
            : Routes.signInScreen,
            (Route<dynamic> route) => false,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color:  kThemeColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Transform.rotate(
              angle: -3.14159265359,
              child: SizedBox(
                height: 30.h,
                width: 100.w,
                child: const CustomImage(
                  path: "assets/images/splash_first.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Transform.rotate(
              angle: -3.14159265359,
              child: SizedBox(
                height: 30.h,
                width: 100.w,
                child: const CustomImage(
                  path: "assets/images/splash_second.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 30.h,
              width: 100.w,
              child: const CustomImage(
                path: "assets/images/splash_first.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 30.h,
              width: 100.w,
              child: const CustomImage(
                path: "assets/images/splash_second.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: 100.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: const Color(0xFFD9D9D9).withOpacity(0.05)),
            child: Transform.scale(
              scale: 0.88,
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFD9D9D9).withOpacity(0.05)),
                child: Transform.scale(
                  scale: 0.72,
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFD9D9D9).withOpacity(0.05)),
                    child: Transform.scale(
                      scale: 0.57,
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFD9D9D9).withOpacity(0.05)),
                        child:  DelayedAnimation(
                          delay: 300,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Lottie.asset("assets/lotties/home_screen_lottie.json"),
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

