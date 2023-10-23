import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/views/utils/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: listOfProvider,
      child: const MyApp(),
    ),
  );
}
