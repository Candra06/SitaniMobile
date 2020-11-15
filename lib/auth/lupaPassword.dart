import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sitani_app/helper/routes.dart';

class LupaSandi extends StatefulWidget {
  @override
  _LupaSandiState createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
  TextEditingController txEmail = new TextEditingController();

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah Anda Yakin?'),
            content: new Text('Ingin Keluar Dari Aplikasi'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'Tidak',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text(
                  'Ya',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Lupa Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'AirbnbBold',
                      color: Colors.red),
                ),
                Image(
                  image: AssetImage('assets/images/password.png'),
                  height: 225.0,
                  width: 225.0,
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 200,
                  ),
                  // color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  // controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email_sharp,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.RESET_SANDI);
                            // if (txEmail.text.isEmpty) {
                            //   Config.alert(0, "Email tidak valid!");
                            // } else if (txpassword.text.isEmpty) {
                            //   Config.alert(0, "Password tidak valid!");
                            // } else {
                            //   login();
                            // }
                            // Navigator.pushNamed(context, Routes.HOMEPAGE,
                            //     arguments: 0.toString());
                            // Navigator.pushNamed(
                            //     context, Routes.HOME_TEKNISI,
                            //     arguments: 0.toString());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'KIRIM',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'AirbnbBold',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: RichText(
                          text: TextSpan(
                              text: '  ',
                              style: TextStyle(
                                  fontFamily: 'Airbnb',
                                  fontSize: 15,
                                  color: Colors.red),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Kembali',
                                    style: TextStyle(
                                      fontFamily: 'AirbnbBold',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // daftar(context);
                                        Navigator.pushNamed(
                                            context, Routes.LOGIN);
                                      })
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
