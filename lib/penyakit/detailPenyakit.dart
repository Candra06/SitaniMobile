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
      jenis = '',
      ciriCiri = '',
      penanggulangan = '',
      pencegahan = '';
  List pupuk = new List();
  void getDetail() async {
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'penyakit/' + widget.idPenyakit,
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        nama = data['data']['nama'];
        foto = data['data']['gambar'];
        jenis = data['data']['jenis'];
        ciriCiri = data['data']['ciri_ciri'];
        penanggulangan = data['data']['penanggulangan'];
        pencegahan = data['data']['pencegahan'];
        pupuk = data['pupuk'];
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
                Config.textMerah,
                Config.textMerah,
                Colors.red
              ]))),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: HexColor('#fffff'),
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal),
                    indicatorColor: Config.darkPrimary,
                    labelColor: Config.darkPrimary,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        text: 'Detail',
                      ),
                      Tab(text: 'Rekomendasi Pupuk'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [detail(), rekomendasiPupuk()],
                ),
              ),
            ],
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
                      jenis,
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
                ciriCiri,
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
                penanggulangan,
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
                pencegahan,
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
                Navigator.pushNamed(context, Routes.PENANGGULANGAN, arguments: pupuk[i]['id'].toString());
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
