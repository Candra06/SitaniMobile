import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/routes.dart';

class SideArtikel extends StatefulWidget {
  @override
  _SideArtikelState createState() => _SideArtikelState();
}

class _SideArtikelState extends State<SideArtikel> {
  List artikel = new List();
  bool load = true;
  void getData() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();

    http.Response req = await http.get(Config.ipServerAPI + 'artikel',
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        artikel = data['data'];
        load = false;
      });
    } else {
      setState(() {
        load = false;
      });
      
      Config.alert(0, 'Gagal Memuat data');
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (artikel.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Tidak ada artikel',
            style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: artikel.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.DETAIL_ARTIKEL,
                    arguments: artikel[i]['id'].toString());
              },
              child: Container(
                color: Config.textWhite,
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage(
                        Config.ipServer + artikel[i]['gambar'],
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      child: Text(
                        artikel[i]['judul'],
                        style:
                            TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: Text(artikel[i]['thumbnail']),
                    )
                  ],
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
        leading: Container(),
        title: new Text(
          'Artikel Pertanian',
          style: TextStyle(color: Config.textWhite),
        ),
        flexibleSpace: new Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
              Config.primary,
              Config.darkPrimary
            ]))),
      ),
      body: Container(
        color: Colors.black12,
        margin: EdgeInsets.only(top: 8),
        child: item(),
      ),
    );
  }
}
