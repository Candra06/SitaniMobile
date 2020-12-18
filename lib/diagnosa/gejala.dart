import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/routes.dart';

class Gejala extends StatefulWidget {
  final String idPenyakit;
  Gejala({this.idPenyakit});
  @override
  _GejalaState createState() => _GejalaState();
}

class _GejalaState extends State<Gejala> {
  String luas = '', nama = '', jenis = '', status = '', total = '';
  List gejala = new List();
  List gjl = [];
  bool tekan = true;
  void press() {
    if (!tekan) {
      setState(() {
        print('tekan');
        tekan = !tekan;
        gjl.add(1);
      });
    } else {
      setState(() {
        print('lepas');
        tekan = !tekan;
        gjl.remove(1);
      });
    }
  }

  bool load = true;
  void getDetail() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response req = await http.get(
        Config.ipServerAPI + 'gejala/' + widget.idPenyakit,
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

  List questionList = [];
  bool val1 = false, val2 = false, val3 = false, val4 = false;

 
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
            return Card(
              child: CheckboxListTile(
                title: Text(gejala[i]['nama_gejala'].toString()),
                controlAffinity: ListTileControlAffinity.leading,
                value: val1,
                onChanged: (bool value) {
                  setState(() {
                    val1 = value;
                  });

                },
                activeColor: Config.primary,
                checkColor: Config.textWhite,
              ),
              // child: Container(
              //   padding: EdgeInsets.all(8),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(gejala[i]['nama_gejala'].toString(),
              //           style: TextStyle(
              //               fontFamily: 'AirbnbMedium', color: Config.primary)),
              //       SizedBox(
              //         height: 8,
              //       ),
              //       Checkbox(
              //           value: questionList.contains(item()),
              //           onChanged: _onRememberMeChanged),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Expanded(
              //             child: Container(
              //               height: 35,
              //               width: MediaQuery.of(context).size.width,
              //               margin: EdgeInsets.fromLTRB(0, 4, 8, 8),
              //               child: RaisedButton(
              //                 padding: EdgeInsets.only(top: 4, bottom: 4),
              //                 color: Config.textWhite,
              //                 onPressed: () {
              //                   press();
              //                 },
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(5),
              //                     side: BorderSide(color: Config.primary)),
              //                 child: Text(
              //                   'Ya',
              //                   style: TextStyle(
              //                       color: Config.primary,
              //                       fontFamily: 'AirbnbBold',
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
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
                      'Centang jika tanaman anda mengalami gejala tersebut.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: 'AirbnbReguler', color: Config.textGrey)),
                ),
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
