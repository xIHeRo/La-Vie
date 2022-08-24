import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //named Constructor

  static const MyApp _instance = MyApp._internal(); // single instance

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getAppThemeData(),
    );
  }
}
