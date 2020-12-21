import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:sitani_app/helper/input.dart';
import 'package:http/http.dart' as http;
import 'package:sitani_app/helper/routes.dart';

class DialogAddPanen extends StatefulWidget {
  final String idLahan;
  DialogAddPanen({this.idLahan});
  @override
  _DialogAddPanenState createState() => _DialogAddPanenState();
}

class _DialogAddPanenState extends State<DialogAddPanen> {
  TextEditingController txthasil = new TextEditingController();
  TextEditingController txtTglPanen = new TextEditingController();
  DateTime tglPanen;
  void simpan() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['id_lahan'] = widget.idLahan;
    body['tanggal_panen'] = txtTglPanen.text;
    body['hasil'] = txthasil.text;
    String token = await Config.getToken();
    http.Response res = await http.post(Config.ipServerAPI + 'addPanen',
        body: body, headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      Config.alert(1, 'Berhasil menambahkan data panen');
      Navigator.pop(context);
      alertLahant();
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal menambahkan data panen');
    }
  }

  void updateLahan() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['id_lahan'] = widget.idLahan;
    body['status'] = 'Nonproduktif';
    String token = await Config.getToken();
    http.Response res = await http.put(
        Config.ipServerAPI + 'update/' + widget.idLahan,
        body: body,
        headers: {'Authorization': 'Bearer $token'});
    print(res.body);
    if (res.statusCode == 200) {
      Config.alert(1, 'Berhasil mengubah status lahan');
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.DETAIL_LAHAN,
          arguments: widget.idLahan);
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal mengubah status lahan');
    }
  }

  alertLahant() {
    return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Status Lahan'),
            content: new Text('Apakah lahan ini masih produktif?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  updateLahan();
                },
                child: new Text(
                  'Tidak',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.DETAIL_LAHAN,
                      arguments: widget.idLahan);
                },
                child: new Text(
                  'Ya',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    print(widget.idLahan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Config.primary,
                Config.primary,
                Config.darkPrimary
              ])),
        ),
        title: Text(
          'Form Hasil Panen',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          style: TextStyle(color: Colors.black54),
                          obscureText: false,
                          controller: txtTglPanen,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  currentDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2022),
                                ).then((date) {
                                  tglPanen = date;
                                  String tanggal = tglPanen
                                      .toString()
                                      .replaceAll("00:00:00.000", "");
                                  print(tanggal);
                                  print(
                                      Config.formattanggal(tanggal.toString()));
                                  txtTglPanen.text = Config.formattanggal(
                                      tglPanen
                                          .toString()
                                          .replaceAll("00:00:00.000", ""));
                                });
                              },
                            ),
                            alignLabelWithHint: true,
                            fillColor: Colors.black54,
                            hintText: "Tanggal Panen",
                            hintStyle: TextStyle(
                                // color: Config.textWhite,
                                fontStyle: FontStyle.italic,
                                fontSize: 16),
                            border: InputBorder.none,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            formInputType(txthasil, 'Hasil Panen(kg)', TextInputType.number),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                color: Config.primary,
                onPressed: () {
                  if (txtTglPanen.text.isEmpty) {
                    Config.alert(0, 'Harap memasukkan tanggal panen');
                  } else if (txthasil.text.isEmpty) {
                    Config.alert(0, 'Harap memasukkan hasil panen');
                  } else {
                    simpan();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Simpan',
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
    );
  }
}
