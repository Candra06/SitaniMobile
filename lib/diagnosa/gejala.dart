import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';

class Gejala extends StatefulWidget {
  final Map<String, dynamic> param;
  Gejala({this.param});
  @override
  _GejalaState createState() => _GejalaState();
}

class _GejalaState extends State<Gejala> {
  String luas = '', nama = '', jenis = '', status = '', total = '';
  List gejala = new List();
  List gjl = [];
  String penyakit = '';

  bool load = true;
  void getDetail() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    String id = widget.param['idPenyakit'];
    http.Response req = await http.get(Config.ipServerAPI + 'gejala/' + id,
        headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        load = false;
        gejala = data['data'];
      });
    } else {
      setState(() {
        load = false;
        Config.alert(0, 'Gagal Memuat data');
      });
    }
  }

  showAlertDialogPositif() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text(
            'Berdasarkan hasil diagnosa, tanaman cabai anda saat ini terserang penyakit ' +
                widget.param['penyakit']),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'Tutup',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          new FlatButton(
            onPressed: () {
              var param = {
                'idPenyakit': widget.param['idPenyakit'],
              };

              Navigator.pushNamed(context, Routes.HASIL, arguments: param);
            },
            child: new Text(
              'Lanjut',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialogNegatif() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text(
            'Berdasarkan hasil diagnosa, Tanaman cabai anda belum dapat dikatakan terserang penyakit ' +
                widget.param['penyakit'] +
                '. Silahkan lakukan diagnosa pada penyakit lain.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, Routes.DIAGNOSA);
            },
            child: new Text(
              'Tutup',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getDetail();
    // print(widget.idLahan);
    super.initState();
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat Data');
    } else if (gejala.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Tidak ada gejala',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: gejala.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                // gjl.add(gejala[i]['id'].toString());
                if (!gjl.contains(gejala[i]['id'].toString())) {
                  setState(() {
                    gjl.add(gejala[i]['id'].toString());
                  });
                } else {
                  setState(() {
                    gjl.remove(gejala[i]['id'].toString());
                  });
                }
                print(gjl);
              },
              child: Card(
                  child: Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Text(gejala[i]['nama_gejala'].toString())),
                    Visibility(
                      child: Icon(
                        !gjl.contains(gejala[i]['id'].toString())
                            ? Icons.check_box_outline_blank
                            : Icons.check_box,
                        color: Colors.green,
                      ),
                      visible: true,
                    )
                  ],
                ),
              )),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.DIAGNOSA);
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
            'Gejala Penyakit',
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
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                      'Centang jika tanaman anda mengalami gejala berikut.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: 'AirbnbReguler', color: Config.textGrey)),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    margin: EdgeInsets.only(bottom: 8),
                    child: item()),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                  child: RaisedButton(
                    padding: EdgeInsets.only(top: 13, bottom: 13),
                    color: Config.primary,
                    onPressed: () {
                      Config.loading(context);
                      Future.delayed(Duration(seconds: 2), () {
                        if (gjl.length == gejala.length) {
                          // all = 'all';
                          print('positif');
                          Navigator.pop(context);
                          showAlertDialogPositif();
                        } else {
                          // all = 'nall';
                          print('negatif');
                          Navigator.pop(context);
                          showAlertDialogNegatif();
                        }
                      });

                      // var param = {
                      //   'idPenyakit': widget.idPenyakit,
                      //   'gejala': all,
                      // };

                      // Navigator.pushNamed(context, Routes.HASIL,
                      //     arguments: param);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'DIAGNOSA',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'AirbnbBold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
