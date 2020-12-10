import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitani_app/auth/login.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';

class SideProfile extends StatefulWidget {
  @override
  _SideProfileState createState() => _SideProfileState();
}

class _SideProfileState extends State<SideProfile> {
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

  // method untuk logout
  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", '');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  alertLogout() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah Anda Yakin?'),
            content: new Text('Ingin logout dari akun ini?'),
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
                onPressed: () {
                  logOut();
                },
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Config.primary,
                      Config.primary,
                      Config.darkPrimary
                    ])),
            //menampilkan detail profile akun
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 38, bottom: 8),
                child: Text(
                  'Profile Anda',
                  style: TextStyle(
                      fontFamily: 'AirbnbBold',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(57.0),
                    child: Image.asset(
                      "assets/images/user.png",
                      fit: BoxFit.fill,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    nama,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
            ]),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: new Column(children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                },
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: new Row(children: <Widget>[
                    new Container(
                        margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        child: new Icon(
                          Icons.border_color,
                          color: Config.primary,
                          size: 25.0,
                        )),
                    new Flexible(
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              'Update Profile',
                              style: TextStyle(fontSize: 14),
                            ))),
                    new ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 25,
                        maxWidth: 110,
                      ),
                      child: Container(
                          child: new IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.UPDATE_PROFIL);
                        },
                      )),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: new Row(children: <Widget>[
                    new Container(
                        margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        child: new Icon(
                          Icons.perm_device_information,
                          color: Config.primary,
                          size: 25.0,
                        )),
                    new Flexible(
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              'Tentang',
                              style: TextStyle(fontSize: 14),
                            ))),
                    new ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 25,
                        maxWidth: 110,
                      ),
                      child: Container(
                          child: new IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          // banned(context);
                        },
                      )),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  alertLogout(); // memanggil method logout
                },
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: new Row(children: <Widget>[
                    new Container(
                        margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        child: new Icon(
                          Icons.power_settings_new,
                          color: Config.primary,
                          size: 25.0,
                        )),
                    new Flexible(
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              'Keluar',
                              style: TextStyle(fontSize: 14),
                            ))),
                    new ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 25,
                        maxWidth: 110,
                      ),
                      child: Container(
                          child: new IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          alertLogout();
                        },
                      )),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
