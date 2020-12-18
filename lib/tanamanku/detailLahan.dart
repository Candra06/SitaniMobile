import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';
import 'package:sitani_app/tanamanku/dialogAddPanen.dart';

class DetailLahan extends StatefulWidget {
  final String idLahan;
  DetailLahan({this.idLahan});
  @override
  _DetailLahanState createState() => _DetailLahanState();
}

class _DetailLahanState extends State<DetailLahan> {
  String luas = '', nama = '', jenis = '', status = '', total = '', tanggal = '';
  List panen = new List();
  bool load = true;
  void getDetail() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'detailLahan/' + widget.idLahan,
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        load = false;
        nama = data['data']['nama_lahan'];
        luas = data['data']['luas'];
        jenis = data['data']['jenis_cabai'];
        status = data['data']['status'];
        tanggal = data['data']['tanggal_tanam'];
        total = data['total_panen'].toString();
        panen = data['panen'];
      });
    } else {}
  }

  @override
  void initState() {
    getDetail();
    print(widget.idLahan);
    super.initState();
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat Data');
    } else if (panen.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Tidak ada riwayat panen',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: panen.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Tanggal penen : ' +
                            Config.formattanggal(
                                panen[i]['tanggal_panen'].toString()),
                        style: TextStyle(
                            fontFamily: 'Airbnb', color: Config.textBlack)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Hasil panen : ' + panen[i]['hasil'].toString() + 'kg',
                        style: TextStyle(
                            fontFamily: 'Airbnb', color: Config.textBlack)),
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.TANAMAN);
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
              Navigator.pushNamed(context, Routes.TANAMAN);
            },
          ),
          title: new Text(
            'Detail Lahan',
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
        floatingActionButton: status == 'Produktif'
            ? FloatingActionButton(
                backgroundColor: Config.primary,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new DialogAddPanen(
                          idLahan: widget.idLahan,
                        );
                      },
                      fullscreenDialog: true));
                })
            : Container(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              nama == '' ? 'Memuat' : nama,
                              style: TextStyle(
                                  color: Config.primary,
                                  fontFamily: 'AirbnbMedium',
                                  fontSize: 16),
                            ),
                            Text(
                              status == '' ? 'Status' : status,
                              style: TextStyle(
                                  color: Config.darkPrimary,
                                  fontFamily: 'AirbnbMedium'),
                            ),
                          ],
                        )),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            jenis == '' ? 'Memuat' : jenis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'AirbnbMedium',
                                fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Tanggal Tanam',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'AirbnbMedium',
                                      fontSize: 16),
                                ),
                                Text(
                                  tanggal == '' ? 'memuat' : Config.formattanggal(tanggal),
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
                                  'Total hasil panen',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'AirbnbMedium',
                                      fontSize: 16),
                                ),
                                Text(
                                  total == '' ? '0' : total + ' kg',
                                  style: TextStyle(
                                      color: Config.darkPrimary,
                                      fontFamily: 'AirbnbMedium'),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Text(
                      'Riwayat Panen',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'AirbnbMedium'),
                    )),
                Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    margin: EdgeInsets.only(bottom: 8),
                    child: item()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
