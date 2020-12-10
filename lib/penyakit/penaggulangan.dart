import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Penanggulangan extends StatefulWidget {
  final String idPenanggulangan;
  Penanggulangan({this.idPenanggulangan});
  @override
  _PenanggulanganState createState() => _PenanggulanganState();
}

class _PenanggulanganState extends State<Penanggulangan> {
  String pupuk = '', penyakit = '', aturan = '';
  bool load = true;
  void getDetail() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    String id = widget.idPenanggulangan;
    http.Response res = await http.get(
        Config.ipServerAPI + 'penyakit/penanggulangan/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data['data']);
      setState(() {
        load = false;
        pupuk = data['data']['nama_pupuk'];
        penyakit = data['data']['nama'];
        aturan = data['data']['aturan_pakai'];
      });
    } else {
      setState(() {
        load = false;
        Config.alert(0, 'Gagal memuat data');
      });
    }
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

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
            'Detail Penanganan',
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
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              if (load) ...{
                Center(child: Config.newloader('Memuat data')),
              } else ...{
                Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Nama Penyakit ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'AirbnbMedium',
                              fontSize: 16),
                        ),
                        Text(
                          penyakit,
                          style: TextStyle(
                              color: Config.darkPrimary,
                              fontFamily: 'AirbnbMedium'),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Pupuk ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'AirbnbMedium',
                              fontSize: 16),
                        ),
                        Text(
                          pupuk == '' ? 'Memuat' : pupuk,
                          style: TextStyle(
                              color: Config.darkPrimary,
                              fontFamily: 'AirbnbMedium'),
                        ),
                      ],
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: Text(
                      'Ciri-ciri',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'AirbnbMedium'),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: HtmlWidget(
                    aturan,
                    textStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              }
            ],
          ),
        )));
  }
}
