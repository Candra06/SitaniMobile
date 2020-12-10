import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sitani_app/auth/login.dart';
import 'package:sitani_app/auth/lupaPassword.dart';
import 'package:sitani_app/auth/register.dart';
import 'package:sitani_app/auth/resetPassword.dart';
import 'package:sitani_app/auth/splash.dart';
import 'package:sitani_app/auth/updateProfil.dart';
import 'package:sitani_app/home/detailArtikel.dart';
import 'package:sitani_app/home/home.dart';
import 'package:sitani_app/penyakit/detailPenyakit.dart';
import 'package:sitani_app/penyakit/listPenyakit.dart';
import 'package:sitani_app/penyakit/penaggulangan.dart';
import 'package:sitani_app/pupuk/detailPupuk.dart';
import 'package:sitani_app/pupuk/listPupuk.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String LUPA_SANDI = '/lupa_sandi';
  static const String RESET_SANDI = '/reset_sandi';
  static const String HOME = '/home';
  static const String UPDATE_PROFIL = '/updateProfil';
  static const String LIST_PUPUK = '/list_pupuk';
  static const String LIST_HAMA = '/list_hama';
  static const String DETAIL_HAMA = '/detail_hama';
  static const String DETAIL_PUPUK = '/detail_pupuk';
  static const String DETAIL_ARTIKEL = '/detail_artikel';
  static const String PENANGGULANGAN = '/penanggulangan';
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
            child: ResetPassword(id: settings.arguments,), type: PageTransitionType.leftToRight);
      case HOME:
        return PageTransition(
            child: Home(indexPage: settings.arguments,), type: PageTransitionType.leftToRight);
      case UPDATE_PROFIL:
        return PageTransition(
            child: UpdateProfil(), type: PageTransitionType.leftToRight);
      case LIST_PUPUK:
        return PageTransition(
            child: ListPupuk(), type: PageTransitionType.leftToRight);
      case LIST_HAMA:
        return PageTransition(
            child: ListHama(), type: PageTransitionType.leftToRight);
      case DETAIL_HAMA:
        return PageTransition(
            child: DetailPenyakit(idPenyakit: settings.arguments,), type: PageTransitionType.leftToRight);
      case DETAIL_PUPUK:
        return PageTransition(
            child: DetailPupuk(idPupuk: settings.arguments,), type: PageTransitionType.leftToRight);
      case DETAIL_ARTIKEL:
        return PageTransition(
            child: DetailArtikel(idArtikel: settings.arguments,), type: PageTransitionType.topToBottom);
      case PENANGGULANGAN:
        return PageTransition(
            child: Penanggulangan(idPenanggulangan: settings.arguments,), type: PageTransitionType.leftToRight);
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
