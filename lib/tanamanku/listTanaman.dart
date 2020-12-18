import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/routes.dart';

class ListTanaman extends StatefulWidget {
  @override
  _ListTanamanState createState() => _ListTanamanState();
}

class _ListTanamanState extends State<ListTanaman> {
  List tanaman = new List();
  bool load = true;
  void getData() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'getLahan',
        headers: {'Authorization': 'Bearer $token'});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data['data']);
      setState(() {
        tanaman = data['data'];
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
    } else if (tanaman.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Data lahan kosong',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: tanaman.isEmpty ? 0 : tanaman.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.DETAIL_LAHAN,
                    arguments: tanaman[i]['id'].toString());
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tanaman[i]['nama_lahan'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium', fontSize: 16),
                          ),
                          Text(
                            tanaman[i]['jenis_cabai'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                fontSize: 14,
                                color: Config.textGrey),
                          ),
                          Text(
                            tanaman[i]['status'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                fontSize: 14,
                                color: Config.primary),
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
            'Tanamanku',
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.ADD_LAHAN);
          },
          backgroundColor: Config.primary,
          child: Icon(Icons.add),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: listData(),
        ),
      ),
    );
  }
}
