import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  final String id;
  ResetPassword({this.id});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isHidden = true, visisble = true;
  TextEditingController txKonfirmpassword = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void hidden() {
    setState(() {
      visisble = !visisble;
    });
  }

  void resetPassword() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['password'] = txpassword.text;
    print(widget.id);
    http.Response req = await http
        .post(Config.ipServerAPI + 'requestPass/' + widget.id, body: body);
    if (req.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil merubah password');
      Navigator.pushNamed(context, Routes.LOGIN);
    } else {
      Config.alert(1, 'Gagal merubah password');
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
                  'Reset Password',
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
                    maxHeight: 220,
                  ),
                  // color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                                    hintText: "Password Baru",
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
                                  obscureText: visisble,
                                  controller: txKonfirmpassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: "Konfirmasi Password",
                                    fillColor: Colors.black54,
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: hidden,
                                      icon: visisble == true
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
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Colors.red,
                          onPressed: () {
                            
                            if (txpassword.text.isEmpty) {
                              Config.alert(0, "Password tidak boleh kosong!");
                            } else if (txKonfirmpassword.text !=
                                txpassword.text) {
                              Config.alert(0, "Password tidak sesuai!");
                            } else {
                              resetPassword();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'SIMPAN',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'AirbnbBold',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
