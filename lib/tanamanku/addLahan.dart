import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sitani_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sitani_app/helper/input.dart';
import 'package:sitani_app/helper/routes.dart';

class AddLahan extends StatefulWidget {
  @override
  _AddLahanState createState() => _AddLahanState();
}

class _AddLahanState extends State<AddLahan> {
  String pupuk = '', penyakit = '', aturan = '';
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtLuas = new TextEditingController();
  TextEditingController txtCabai = new TextEditingController();
  TextEditingController txtTglTanam = new TextEditingController();
  List<String> listCabai = new List();
  List<String> idCabai = new List();
  DateTime tglTanam;
  String getCacbai = "";

  List<DropdownMenuItem<String>> status;
  String getStatus = "";
  List listStatus = [
    'Pilih Status Lahan',
    'Produktif',
    'NonProduktif',
  ];

  void changedDropDownItemStatus(String selectedStatus) {
    setState(() {
      getStatus = selectedStatus;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsStatus() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listStatus) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  bool load = true;
  void getCabai() async {
    String token = await Config.getToken();
    http.Response req = await http.get(Config.ipServerAPI + 'cabai',
        headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      List<String> val = new List();
      List<String> idMpl = new List();
      List tmp = data['data'];
      for (var i = 0; i < tmp.length; i++) {
        val.add(tmp[i]['jenis_cabai'] + '(' + tmp[i]['nama_latin'] + ')');
        idMpl.add(tmp[i]['id'].toString());
      }
      setState(() {
        print(val);
        listCabai = val;
        idCabai = idMpl;
      });
    } else {
      setState(() {
        Config.alert(0, 'Gagal memuat data');
      });
    }
  }

  void simpanData() async {
    Config.loading(context);
    String token = await Config.getToken();
    var body = new Map<String, dynamic>();
    body['id_cabai'] = getCacbai;
    body['nama_lahan'] = txtNama.text;
    body['luas'] = txtLuas.text;
    body['tanggal_tanam'] = txtTglTanam.text;
    body['status'] = getStatus;
    print(body);
    // String id = widget.idPenanggulangan;
    http.Response res = await http.post(Config.ipServerAPI + 'addLahan',
        body: body, headers: {'Authorization': 'Bearer $token'});
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil Menambahkan data');
      Navigator.pushNamed(context, Routes.TANAMAN);
    } else {
      setState(() {
        Navigator.pop(context);
        Config.alert(2, 'Gagal Menambahkan data');
      });
    }
  }

  @override
  void initState() {
    status = getDropDownMenuItemsStatus();
    getStatus = status[0].value;
    getCabai();
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
            'Tambah Lahan',
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
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: DropdownSearch(
                    mode: Mode.MENU,
                    searchBoxController: txtCabai,
                    showSearchBox: true,
                    showSelectedItem: true,
                    items:
                        listCabai == null ? ['Pilih Jenis Cabai'] : listCabai,
                    label: listCabai == null ? 'Memuat' : "Jenis Cabai",
                    hint: "Pilih Jenis Cabai",
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (value) {
                      setState(() {
                        // txtCabai = value;
                        getCacbai = idCabai[listCabai.indexOf(value)];
                        print(getCacbai);
                      });
                    },
                    // selectedItem: ,
                  )),
              formInput(txtNama, 'Nama Lahan'),
              formInput(txtLuas, 'Luas Lahan(m2)'),
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
                            controller: txtTglTanam,
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    currentDate: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2012),
                                    lastDate: DateTime.now(),
                                  ).then((date) {
                                    tglTanam = date;
                                    String tanggal = tglTanam
                                        .toString()
                                        .replaceAll("00:00:00.000", "");
                                    print(tanggal);
                                    print(Config.formattanggal(
                                        tanggal.toString()));
                                    txtTglTanam.text = Config.formattanggal(
                                        tglTanam
                                            .toString()
                                            .replaceAll("00:00:00.000", ""));
                                  });
                                },
                              ),
                              alignLabelWithHint: true,
                              fillColor: Colors.black54,
                              hintText: "Tanggal Tanam",
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
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    child: DropdownButton(
                      underline: SizedBox(),
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Config.textBlack,
                      ),
                      hint: Text(
                        'Pilih Status Lahan',
                        style: TextStyle(color: Colors.black54),
                      ),
                      items: status,
                      onChanged: changedDropDownItemStatus,
                      value: getStatus,
                      style: TextStyle(
                          color: Config.textBlack, fontFamily: 'Airbnb'),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Config.textMerah,
                      Config.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FlatButton(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  color: Colors.transparent,
                  onPressed: () {
                    if (txtNama.text.isEmpty) {
                      Config.alert(2, "Nama Lahan tidak boleh kosong");
                    } else if (getCacbai == '') {
                      Config.alert(2, "Harap memilih jenis cabai");
                    } else if (txtLuas.text.isEmpty) {
                      Config.alert(2, "Luas Lahan tidak boleh kosong");
                    } else if (txtTglTanam.text.isEmpty) {
                      Config.alert(2, "Tanggal tanam tidak boleh kosong");
                    } else {
                      simpanData();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
