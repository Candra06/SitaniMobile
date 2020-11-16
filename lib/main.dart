
import 'package:sitani_app/helper/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitani_app/helper/routes.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(AppConfig(
      appName: "Sitani Dev",
      flavorName: "dev",
      initialRoute: Routes.SPLASH,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var initialRoute = AppConfig.of(context).initialRoute;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: initialRoute,
      title: 'Sitani App',
    );
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }
}