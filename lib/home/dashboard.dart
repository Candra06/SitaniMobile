import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/fade_animation.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String nama = 'User';
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return new SafeArea(
        child: new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          FadeAnimation(
            1.4,
            new Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  FadeAnimation(
                    1.2,
                    new Container(
                      width: cWidth,
                      padding: EdgeInsets.only(right: 16, left: 16, top: 20),
                      height: 200,
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)),
                          gradient: new LinearGradient(
                            colors: <Color>[Config.textMerah, Config.primary],
                            end: Alignment(1.5, 0.0),
                          )),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "Selamat Datang",
                            style: new TextStyle(
                              fontFamily: 'AirbnbBold',
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Text(
                            nama,
                            style: new TextStyle(
                              fontFamily: 'AirbnbBold',
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: new Container(
                          decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.circular(20.0)),
                          width: cWidth,
                          margin: EdgeInsets.only(right: 16, left: 16),
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Container(
                                      //   child: Text(plant.toString(),
                                      //       style: TextStyle(
                                      //           color: Config.darkprimary,
                                      //           fontSize: 32,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      Container(
                                        child: Text('Data Tanaman',
                                            style: TextStyle(
                                                color: Colors.black45)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.black45,
                                    width: 10,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Container(
                                      //   child: Text(desease.toString(),
                                      //       style: TextStyle(
                                      //           color: Config.darkprimary,
                                      //           fontSize: 32,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      Container(
                                        child: Text('Data Penyakit',
                                            style: TextStyle(
                                                color: Colors.black45)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.black45,
                                    width: 10,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Container(
                                      //   child: Text(user.toString(),
                                      //       style: TextStyle(
                                      //           color: Config.darkprimary,
                                      //           fontSize: 32,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      Container(
                                        child: Text(
                                          'Data Akun',
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
