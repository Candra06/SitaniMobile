import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/routes.dart';

class ListPupuk extends StatefulWidget {
  @override
  _ListPupukState createState() => _ListPupukState();
}

class _ListPupukState extends State<ListPupuk> {
  List pupuk = new List();
  bool load = true;

  void getData() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'pupuk',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        pupuk = data['data'];
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
    } else if (pupuk.isEmpty) {
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
          itemCount: pupuk.isEmpty ? 0 : pupuk.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.DETAIL_PUPUK,
                    arguments: pupuk[i]['id'].toString());
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.local_florist_outlined,
                          color: Config.primary,
                          size: 30,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pupuk[i]['nama_pupuk'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium', fontSize: 16),
                          ),
                          Text(
                            pupuk[i]['type'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                fontSize: 14,
                                color: Config.textGrey),
                          ),
                          Text(
                            pupuk[i]['harga'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                fontSize: 14,
                                color: Config.textGrey),
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
          'Info Pupuk dan Pestisida',
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
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: listData(),
      ),
    );
  }
}
