import 'package:flutter/material.dart';
import 'package:mealtracker/src/services/shared_preference_services/shared_prefs_services.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/views/utils/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsServices.init();
  runApp(
    MultiProvider(
      providers: listOfProvider,
      child: const MyApp(),
    ),
  );
}
