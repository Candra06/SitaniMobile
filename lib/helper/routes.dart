import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sitani_app/auth/login.dart';
import 'package:sitani_app/auth/lupaPassword.dart';
import 'package:sitani_app/auth/register.dart';
import 'package:sitani_app/auth/resetPassword.dart';
import 'package:sitani_app/auth/splash.dart';
import 'package:sitani_app/home/home.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String LUPA_SANDI = '/lupa_sandi';
  static const String RESET_SANDI = '/reset_sandi';
  static const String HOME = '/home';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return PageTransition(
            child: LoginPage(), type: PageTransitionType.topToBottom);
      case REGISTER:
        return PageTransition(
            child: RegisterPage(), type: PageTransitionType.topToBottom);
      case LUPA_SANDI:
        return PageTransition(
            child: LupaSandi(), type: PageTransitionType.leftToRight);
      case RESET_SANDI:
        return PageTransition(
            child: ResetPassword(), type: PageTransitionType.leftToRight);
      case HOME:
        return PageTransition(
            child: Home(indexPage: settings.arguments,), type: PageTransitionType.leftToRight);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Page ${settings.name} not defined'),
                  ),
                ));
    }
  }
}
