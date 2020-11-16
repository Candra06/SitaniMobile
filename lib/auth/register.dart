import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHidden = true;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  TextEditingController txNama = new TextEditingController();
  TextEditingController txKecamatan = new TextEditingController();
  TextEditingController txAlamat = new TextEditingController();
  TextEditingController txTelepon = new TextEditingController();
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void register() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['nama'] = txNama.text;
    body['telepon'] = txTelepon.text;
    body['kecamatan'] = txKecamatan.text;
    body['alamat'] = txAlamat.text;
    body['email'] = txEmail.text;
    body['password'] = txpassword.text;
    print(body);
    var req = await http.post(Config.ipServerAPI + 'register', body: body);
    print(Config.ipServerAPI + 'register');
    print(req.body);
    if (req.statusCode == 200) {
      Config.alert(1, 'Registrasi berhasil, silahkan login!');
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.LOGIN);
    } else {
      Config.alert(0, 'Registrasi gagal, silahkan periksa data anda!');
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
            margin: EdgeInsets.only(top: 32),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Daftar',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'AirbnbBold',
                      color: Colors.red),
                ),
                Image(
                  image: AssetImage('assets/images/personal_data.png'),
                  height: 225.0,
                  width: 225.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
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
                                  keyboardType: TextInputType.text,
                                  controller: txNama,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(
                                      Icons.account_box,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black54,
                                    hintText: "Nama",
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
                        margin: EdgeInsets.only(top: 8),
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
                                  keyboardType: TextInputType.phone,
                                  controller: txTelepon,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black54,
                                    hintText: "Telepon",
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
                        margin: EdgeInsets.only(top: 8),
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
                                  keyboardType: TextInputType.text,
                                  controller: txKecamatan,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(
                                      Icons.location_city_outlined,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black54,
                                    hintText: "Kecamatan",
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
                        margin: EdgeInsets.only(top: 8),
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
                                  controller: txAlamat,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(
                                      Icons.map,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black54,
                                    hintText: "Alamat",
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
                        margin: EdgeInsets.only(top: 8),
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
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(
                                      Icons.alternate_email_sharp,
                                      color: Colors.black54,
                                    ),
                                    focusColor: Colors.black54,
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
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Colors.red,
                          onPressed: () {
                            if (txNama.text == '' || txNama.text == null) {
                              Config.alert(2, "Nama tidak boleh kosong");
                            } else if (txTelepon.text == '' ||
                                txTelepon.text == null) {
                              Config.alert(2, "Telepon tidak boleh kosong");
                            } else if (txKecamatan.text == '' ||
                                txKecamatan.text == null) {
                              Config.alert(2, "Kecamatan tidak boleh kosong");
                            } else if (txAlamat.text == '' ||
                                txAlamat.text == null) {
                              Config.alert(2, "Alamat tidak boleh kosong");
                            } else if (txEmail.text == '' ||
                                txEmail.text == null) {
                              Config.alert(2, "Email tidak boleh kosong");
                            } else if (txpassword.text == '' ||
                                txpassword.text == null) {
                              Config.alert(2, "Password tidak boleh kosong");
                            } else {
                              register();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'DAFTAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'AirbnbBold',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: RichText(
                          text: TextSpan(
                              text: 'Sudah punya akun? ',
                              style: TextStyle(
                                  fontFamily: 'Airbnb',
                                  fontSize: 15,
                                  color: Colors.red),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      fontFamily: 'AirbnbBold',
                                    ),
                                    //     color: Config.textDark),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
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
