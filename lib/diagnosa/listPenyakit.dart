import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/routes.dart';

class ListDiagnosaPenyakit extends StatefulWidget {
  @override
  _ListDiagnosaPenyakitState createState() => _ListDiagnosaPenyakitState();
}

class _ListDiagnosaPenyakitState extends State<ListDiagnosaPenyakit> {
  List hama = new List();
  bool load = true;
  void getData() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'penyakit',
        headers: {'Authorization': 'Bearer $token'});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        hama = data['data'];
        load = false;
      });
    } else {
      setState(() {
        load = false;
        Config.alert(0, 'Gagal menampilkan data');
      });
    }
  }

  Widget listData() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (hama.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Data Penyakit dan Hama Kosong',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: hama.isEmpty ? 0 : hama.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.GEJALA, arguments: hama[i]['id'].toString());
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        margin: EdgeInsets.only(right: 8),
                        child: Image.network(Config.ipServer+hama[i]['gambar'], height: 50,width: 50,)
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hama[i]['nama'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium', fontSize: 16),
                          ),
                         
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.HOME, arguments: '0');
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
              Navigator.pushNamed(context, Routes.HOME, arguments: '0');
            },
          ),
          title: new Text(
            'Diagnosa Tanaman',
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
       
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: listData(),
        ),
      ),
    );
  }
}
