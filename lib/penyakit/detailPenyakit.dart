import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/hexColor.dart';
import 'package:sitani_app/helper/routes.dart';

class DetailPenyakit extends StatefulWidget {
  final String idPenyakit;
  DetailPenyakit({this.idPenyakit});
  @override
  _DetailPenyakitState createState() => _DetailPenyakitState();
}

class _DetailPenyakitState extends State<DetailPenyakit> {
  String foto = '',
      nama = '',
      deskripsi = '',
      penanganan = '';
  List pupuk = new List();
  void getDetail() async {
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'penyakit/' + widget.idPenyakit,
        headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        nama = data['data']['nama'];
        foto = data['data']['gambar'];
        deskripsi = data['data']['deskripsi'];
        penanganan = data['data']['penanganan'];
        print(foto);
      });
    } else {}
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
            'Detail Penyakit dan Hama',
            style: TextStyle(color: Config.textWhite),
          ),
          flexibleSpace: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
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
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: foto == ''
                      ? Config.newloader('Memuat data')
                      : CachedNetworkImage(
                          imageUrl: Config.ipServer + foto.toString(),
                          height: 110,
                          width: 110,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                ),
               
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: Text(
                      'Deskripsi',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'AirbnbMedium'),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: HtmlWidget(
                    deskripsi == null || deskripsi == '' ? 'Memuat data' :deskripsi,
                    textStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: Text(
                      'Penanganan',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'AirbnbMedium'),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: HtmlWidget(
                    penanganan == null || penanganan == '' ? 'Memuat data' :penanganan,
                    textStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
