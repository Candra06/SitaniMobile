import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/fade_animation.dart';
import 'package:sitani_app/helper/routes.dart';

class UpdateProfil extends StatefulWidget {
  @override
  _UpdateProfilState createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil> {
  bool _isHidden = true;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  TextEditingController txNama = new TextEditingController();
  TextEditingController txKecamatan = new TextEditingController();
  TextEditingController txAlamat = new TextEditingController();
  TextEditingController txTelepon = new TextEditingController();
  String token = '', id = '';
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void getInfo() async {
    var nama = await Config.getNama();
    var email = await Config.getEmail();
    var kecamatan = await Config.getKecamatan();
    var telepon = await Config.getTelepon();
    var alamat = await Config.getAlamat();
    var xtoken = await Config.getToken();
    var xid = await Config.getID();

    setState(() {
      txEmail.text = email.toString();
      txNama.text = nama.toString();
      txAlamat.text = alamat.toString();
      txTelepon.text = telepon.toString();
      txKecamatan.text = kecamatan.toString();
      id = xid.toString();
      token = xtoken.toString();
    });
  }

  void updateData() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['nama'] = txNama.text;
    body['email'] = txEmail.text;
    body['telepon'] = txTelepon.text;
    body['alamat'] = txAlamat.text;
    body['kecamatan'] = txKecamatan.text;
    body['password'] = txpassword.text;

    http.Response req = await http.post(Config.ipServerAPI + 'update',
        headers: {'Authorization': 'Bearer $token'}, body: body);
        print(req.body);
    if (req.statusCode == 200) {
      Config.alert(1, 'Data berhasil dirubah');
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", token);
      await pref.setString("nama", txNama.text);
      await pref.setString("id", id);
      await pref.setString("email",  txEmail.text);
      await pref.setString("alamat", txAlamat.text);
      await pref.setString("kecamatan", txKecamatan.text);
      await pref.setString("telepon",  txTelepon.text);
      await pref.setString("username",  txEmail.text);
      
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.HOME, arguments: 2.toString());
    } else {
      Config.alert(0, 'Data gagal dirubah');
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Config.textWhite,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: new Text(
          'Edit Akun',
          style: TextStyle(color: Config.textWhite),
        ),
        flexibleSpace: new Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
              Config.textMerah,
              Config.textMerah,
              Colors.red
            ]))),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Center(
            child: Container(
                margin: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.fromLTRB(0, 8, 0, 16),
                        child: new Text(
                          'Silahkan lengkapi data akun berikut dengan benar.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      FadeAnimation(
                        1.8,
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                          style:
                                              TextStyle(color: Colors.black54),
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        3.0,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          decoration: new BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Config.textMerah,
                                Config.primary,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Colors.transparent,
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
                                // register();
                                updateData();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Simpan',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      }),
    );
  }
}
