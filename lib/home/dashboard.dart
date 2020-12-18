import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: Container(
        color: Config.background,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            FadeAnimation(
              1.4,
              new Container(
                height: 250,
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
                              colors: <Color>[
                                Config.primary,
                                Config.primary,
                                Config.darkPrimary
                              ],
                              end: Alignment(1.5, 0.0),
                            )),
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
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              margin: EdgeInsets.only(right: 16, left: 16),
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(16),
                                        child: Image.asset(
                                          'assets/images/farmer.png',
                                          height: 70,
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        new Text("Selamat Datang",
                                            style: GoogleFonts.lato(
                                              textStyle: new TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Config.textBlack,
                                              ),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        new Text(nama,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Config.textGrey,
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ))
                  ],
                ),
              ),
            ),
            FadeAnimation(
                1.4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.DIAGNOSA);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 8, 8),
                        padding: EdgeInsets.all(16),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Config.textWhite,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/diagnose.png',
                              height: 50,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Diagnosa Tanaman',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Config.textBlack,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.TANAMAN);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        padding: EdgeInsets.all(16),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Config.textWhite,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/plant.png',
                              height: 50,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text('Tanamanku',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Config.textBlack,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                      ),
                    ))
                  ],
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
                            height: 150,
                            decoration: BoxDecoration(
                                color: Config.textWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/fertilizer.png',
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Info Pupuk dan Pestisida',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Config.textBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    )),
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
                            height: 150,
                            margin: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                                color: Config.textWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/pest.png',
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Info Penyakit dan Hama',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Config.textBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    )),
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
      ),
    ));
  }
}
