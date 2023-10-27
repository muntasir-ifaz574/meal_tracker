import 'package:flutter/material.dart';
import 'package:mealtracker/src/routes.dart';
import 'package:mealtracker/src/views/ui/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'views/utils/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFF002E70, colorMap)
          ),
          routes: Routes.routes,
          home: const SplashScreen(),
        );
      }
    );
  }
}
