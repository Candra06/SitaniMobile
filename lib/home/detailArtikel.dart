import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';

class DetailArtikel extends StatefulWidget {
  final String idArtikel;
  DetailArtikel({this.idArtikel});
  @override
  _DetailArtikelState createState() => _DetailArtikelState();
}

class _DetailArtikelState extends State<DetailArtikel> {
  String foto = '',
      judul = '',
      penulis = '',
      createdAt = '',
      konten = '',
      pencegahan = '';
  List pupuk = new List();
  void getDetail() async {
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'artikel/' + widget.idArtikel,
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      print(data['data']);
      setState(() {
        judul = data['data']['judul'];
        foto = data['data']['gambar'];
        penulis = data['data']['writer'];
        createdAt = data['data']['created_at'];
        konten = data['data']['konten'];
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
        body: SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
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
                   width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black12
                  ),
                ),
                Positioned(
                    left: 10,
                    top: 20,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Config.textWhite),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.HOME,
                                arguments: '1');
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Config.primary,
                          ),
                        ))),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                judul,
                style: TextStyle(fontFamily: 'AirbnbBold', fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Text(
                'Penulis : ' + penulis,
                style: TextStyle(
                    fontFamily: 'AirbnbMedium',
                    fontSize: 16,
                    color: Config.textGrey),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                Config.formattanggal(
                    createdAt.toString().replaceAll('00:00:00', '')),
                style: TextStyle(
                    fontFamily: 'AirbnbReguler',
                    fontSize: 14,
                    color: Config.textGrey),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: HtmlWidget(
                konten,
                textStyle: TextStyle(fontFamily: 'AirbnbReguler'),
              ),
            )
          ],
        ),
      ),
    ));
  }

  detail() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 4, bottom: 8),
                child: Center(
                  child: Text('nama',
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
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
                      'jenis',
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
                'ciriCiri',
                textStyle: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: Text(
                  'Penanggulangan',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: 'AirbnbMedium'),
                )),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: HtmlWidget(
                'penanggulangan',
                textStyle: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: Text(
                  'Pencegahan',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: 'AirbnbMedium'),
                )),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: HtmlWidget(
                'pencegahan',
                textStyle: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  rekomendasiPupuk() {
    return Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: pupuk.isEmpty ? 0 : pupuk.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.PENANGGULANGAN,
                    arguments: pupuk[i]['id'].toString());
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pupuk[i]['nama_pupuk'],
                          style: TextStyle(
                              fontFamily: 'AirbnbMedium',
                              color: Config.darkPrimary,
                              fontSize: 16)),
                      Text(
                        pupuk[i]['type'],
                        style: TextStyle(
                            fontFamily: 'Airbnb', color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
