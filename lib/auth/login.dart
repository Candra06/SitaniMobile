import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void login() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['email'] = txEmail.text;
    body['password'] = txpassword.text;

    var res = await http.post(Config.ipServerAPI + 'login', body: body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var token = data['data']['token'];
      var req = await http.post(Config.ipServerAPI + 'details',
          headers: {'Authorization': 'Bearer $token'});
      var info = json.decode(req.body);
      var nama = info['data']['nama'].toString();
      var id = info['data']['id'].toString();
      var email = info['data']['email'].toString();
      var alamat = info['data']['alamat'].toString();
      var kecamatan = info['data']['kecamatan'].toString();
      var telepon = info['data']['telepon'].toString();
      var username = info['data']['username'].toString();
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", token);
      await pref.setString("nama", nama);
      await pref.setString("id", id);
      await pref.setString("email", email);
      await pref.setString("alamat", alamat);
      await pref.setString("kecamatan", kecamatan);
      await pref.setString("telepon", telepon);
      await pref.setString("username", username);
      
      Navigator.pop(context);
      Config.alert(1, 'Login Berhasil');
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, Routes.HOME, arguments: 0.toString());
      });
    } else {
      Config.alert(2, "Login gagal. Silahkan cek kembali data anda");
      Navigator.pop(context);
    }
  }

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
                  'Login',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'AirbnbBold',
                      color: Colors.red),
                ),
                Image(
                  image: AssetImage('assets/images/authentication.png'),
                  height: 225.0,
                  width: 225.0,
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 300,
                  ),
                  // color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(top: 8),
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
                                  controller: txEmail,
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
                        margin: EdgeInsets.only(top: 8, bottom: 8),
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
                                  obscureText: _isHidden,
                                  controller: txpassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: "Password",
                                    fillColor: Colors.black54,
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility_off,
                                              color: Colors.black45)
                                          : Icon(Icons.visibility,
                                              color: Colors.black45),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.LUPA_SANDI);
                            },
                            child: Text(
                              'Lupa Password?',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'AirBnb',
                                  color: Colors.red,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Colors.red,
                          onPressed: () {
                            if (txEmail.text.isEmpty) {
                              Config.alert(0, "Email tidak valid!");
                            } else if (txpassword.text.isEmpty) {
                              Config.alert(0, "Password tidak valid!");
                            } else {
                              login();
                            }
                            // Navigator.pushNamed(context, Routes.HOMEPAGE,
                            //     arguments: 0.toString());
                            // Navigator.pushNamed(context, Routes.HOME,
                            //     arguments: 0.toString());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'LOGIN',
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
                              text: 'Belum punya akun? ',
                              style: TextStyle(
                                  fontFamily: 'Airbnb',
                                  fontSize: 15,
                                  color: Colors.red),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Daftar Baru',
                                    style: TextStyle(
                                      fontFamily: 'AirbnbBold',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // daftar(context);
                                        Navigator.pushNamed(
                                            context, Routes.REGISTER);
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
