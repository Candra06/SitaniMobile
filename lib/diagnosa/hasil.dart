import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';

class Hasil extends StatefulWidget {
  final Map<String, dynamic> param;
  Hasil({this.param});
  @override
  _HasilState createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  String foto = '', nama = '', deskripsi = '', penanganan = '';
  bool load = true;
  List pupuk = new List();
  void getDetail() async {
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'penyakit/' + widget.param['idPenyakit'],
        headers: {'Authorization': 'Bearer $token'});

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

  void getPupuk() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'rekomendasi/' + widget.param['idPenyakit'],
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        pupuk = data['data'];
        load = false;
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
    getPupuk();
    print(widget.param);
    super.initState();
  }

  Widget item(i) {
    if (load) {
      return Config.newloader('Memuat Data');
    } else if (pupuk.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Tidak ada rekomendasi pestisida',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          var param = {
            'idPupuk': pupuk[i]['id'].toString(),
            'idPenyakit': widget.param['idPenyakit'],
          };
          // print(pupuk[i]['id'].toString());
          Navigator.pushNamed(context, Routes.REKOMENDASI, arguments: param);
        },
        child: Container(
          margin: EdgeInsets.only(top: 4),
          child: Card(
              child: Container(
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    child: Text(pupuk[i]['nama_pupuk'].toString())),
              ],
            ),
          )),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, Routes.DIAGNOSA);
          // Navigator.pop(context);
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
                  Navigator.pushNamed(context, Routes.DIAGNOSA);
                },
              ),
              title: new Text(
                'Hasil Diagnosa',
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
                        deskripsi == null || deskripsi == ''
                            ? 'Memuat data'
                            : deskripsi,
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
                        penanganan == null || penanganan == ''
                            ? 'Memuat data'
                            : penanganan,
                        textStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rekomendasi Pupuk dan Pestisida',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'AirbnbMedium',
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    for (var i = 0; i < pupuk.length; i++) ...{item(i)}
                  ],
                ),
              ),
            )));
  }
}
