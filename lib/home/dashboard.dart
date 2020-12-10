import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/fade_animation.dart';
import 'package:sitani_app/helper/routes.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String nama = '', email = '', token = '';
  void getInfo() async {
    var xnama = await Config.getNama();
    var xemail = await Config.getEmail();
    var xtoken = await Config.getToken();
    setState(() {
      nama = xnama;
      email = xemail;
      token = xtoken;
    });
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
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
                      padding: EdgeInsets.only(right: 16, left: 16, top: 38),
                      height: 200,
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)),
                          gradient: new LinearGradient(
                            colors: <Color>[Config.textMerah, Config.primary, Config.darkPrimary],
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
                  // Positioned(
                  //   bottom: 10,
                  //   right: 0,
                  //   left: 0,
                  //   child:
                  
                  // )
                ],
              ),
            ),
          ),
          FadeAnimation(
              1.4,
              Container(
                margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Config.boxGreen,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_florist,
                      size: 50,
                      color: Config.textWhite,
                    ),
                    Text(
                      'Diagnosa Tanaman',
                      style: TextStyle(
                          fontFamily: 'AirbnbMedium',
                          color: Config.textWhite,
                          fontSize: 18),
                    ),
                  ],
                ),
              )),
          FadeAnimation(
              1.6,
              Container(
                margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LIST_PUPUK);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: Config.boxYellowLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_florist,
                                size: 50,
                                color: Config.textWhite,
                              ),
                              Text(
                                'Info Pupuk dan Pestisida',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.textWhite,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LIST_HAMA);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              color: Config.boxYellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bug_report,
                                size: 50,
                                color: Config.textWhite,
                              ),
                              Text(
                                'Info Penyakit dan Hama',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.textWhite,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
