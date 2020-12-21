import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';

class Rekomendasi extends StatefulWidget {
  final Map<String, dynamic> param;
  Rekomendasi({this.param});
  @override
  _RekomendasiState createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  String foto = '', nama = '', deskripsi = '', penanganan = '';
  bool load = true;
  List pupuk = new List();
  void getDetail() async {
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'detailPupuk/' + widget.param['idPupuk'],
        headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        nama = data['data']['nama_pupuk'];
        deskripsi = data['data']['aturan_pakai'];
      });
    } else {}
  }

  @override
  void initState() {
    getDetail();
    print(widget.param);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          var param = {
            'idPenyakit': widget.param['idPenyakit'],
          };
          Navigator.pushNamed(context, Routes.HASIL, arguments: param);
        },
        child: Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Config.textWhite,
                ),
                onPressed: () {
                  var param = {
                    'idPenyakit': widget.param['idPenyakit'],
                  };
                  Navigator.pushNamed(context, Routes.HASIL, arguments: param);
                },
              ),
              title: new Text(
                'Aturan Pakai',
                style: TextStyle(color: Config.textWhite),
              ),
              flexibleSpace: new Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                Config.primary,
                Config.primary,
                Config.darkPrimary
              ]))),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 4, bottom: 8),
                        child: Center(
                          child: Text(nama,
                              style: TextStyle(
                                color: Config.darkPrimary,
                                fontSize: 20,
                                fontFamily: 'AirbnbBold',
                              )),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        child: Text(
                          'Aturan Pakai',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: 'AirbnbMedium'),
                        )),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: HtmlWidget(
                        deskripsi == null || deskripsi == ''
                            ? 'Memuat data'
                            : deskripsi,
                        textStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
