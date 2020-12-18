import 'package:flutter/material.dart';

Widget formInput(TextEditingController controller, label) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: TextFormField(
                style: TextStyle(color: Colors.black54),
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: controller,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  fillColor: Colors.black54,
                  hintText: label,
                  hintStyle: TextStyle(
                      // color: Config.textWhite,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                  border: InputBorder.none,
                )),
          )
        ],
      ),
    );
  }

  Widget formInputType(TextEditingController controller, label, TextInputType type) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: TextFormField(
                style: TextStyle(color: Colors.black54),
                obscureText: false,
                keyboardType: type,
                controller: controller,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  fillColor: Colors.black54,
                  hintText: label,
                  hintStyle: TextStyle(
                      // color: Config.textWhite,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                  border: InputBorder.none,
                )),
          )
        ],
      ),
    );
  }