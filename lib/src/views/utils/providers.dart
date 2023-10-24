import 'package:mealtracker/src/business_logics/providers/auth_provider.dart';
import 'package:mealtracker/src/business_logics/providers/common_provider.dart';
import 'package:provider/provider.dart';
import '../../business_logics/providers/app_provider.dart';

final listOfProvider = [
  ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
  ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
  ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
];
