
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sitani_app/helper/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailPupuk extends StatefulWidget {
  final String idPupuk;
  DetailPupuk({this.idPupuk});
  @override
  _DetailPupukState createState() => _DetailPupukState();
}

class _DetailPupukState extends State<DetailPupuk> {
  String nama = '',
      deskripsi = '',
      kandungan = '',
      gambar = '',
      harga = '',
      aturanPakai = '',
      type = '',
      jenis = '';

  bool load = true;
  void getDetail() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    String id = widget.idPupuk;
    http.Response res = await http.get(Config.ipServerAPI + 'pupuk/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        load = false;
        nama = data['data']['nama_pupuk'];
        deskripsi = data['data']['deskripsi'];
        kandungan = data['data']['kandungan'];
        aturanPakai = data['data']['aturan_pakai'];
        jenis = data['data']['jenis'];
        harga = data['data']['harga'];
        type = data['data']['type'];
        gambar = data['data']['gambar'];
      });
    } else {
      Config.alert(0, 'Gagal Memuat data');
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
          'Detail Pupuk dan Pestisida',
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
                Config.newloader('Memuat data'),
              } else ...{
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: gambar == ''
                      ? Config.newloader('Memuat data')
                      : CachedNetworkImage(
                          imageUrl: Config.ipServer + gambar.toString(),
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
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Nama ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'AirbnbMedium',
                              fontSize: 16),
                        ),
                        Text(
                          nama,
                          style: TextStyle(
                              color: Config.darkPrimary,
                              fontFamily: 'AirbnbMedium'),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Jenis ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'AirbnbMedium',
                              fontSize: 16),
                        ),
                        Text(
                          jenis,
                          style: TextStyle(
                              color: Config.darkPrimary,
                              fontFamily: 'AirbnbMedium'),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Type ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'AirbnbMedium',
                              fontSize: 16),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                              color: Config.darkPrimary,
                              fontFamily: 'AirbnbMedium'),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Kisaran Harga ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'AirbnbMedium',
                              fontSize: 16),
                        ),
                        Text(
                          harga,
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
                    deskripsi,
                    textStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: Text(
                      'Kandungan',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'AirbnbMedium'),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: HtmlWidget(
                    kandungan,
                    textStyle: TextStyle(color: Colors.black54),
                  ),
                ),
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
                    aturanPakai,
                    textStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
