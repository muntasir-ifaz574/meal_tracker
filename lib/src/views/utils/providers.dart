import 'package:provider/provider.dart';
import '../../business_logics/providers/app_provider.dart';

final listOfProvider = [
  ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),

];
