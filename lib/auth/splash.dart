import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sitani_app/auth/login.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/home/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () async {

      Navigator.of(context).pushReplacement(PageTransition(
              child: LoginPage(), type: PageTransitionType.fade));
      String token = await Config.getToken();
        if (token == '' || token == null) {
          Navigator.of(context).pushReplacement(PageTransition(
              child: LoginPage(), type: PageTransitionType.fade));
        } else {
          Navigator.of(context).pushReplacement(
              PageTransition(child: Home(indexPage: 0.toString(),), type: PageTransitionType.fade));
        }

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      'SITANI',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 35,
                          fontFamily: 'AirBnbBold'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
