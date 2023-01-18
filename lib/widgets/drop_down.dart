import 'package:flutter/material.dart';

Widget customDropDown(
  List<String> items,
  String value,
  void onChange(val)
){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0,),
    decoration: BoxDecoration(
      color: Colors.orange[100],
      borderRadius: BorderRadius.circular(40).copyWith(bottomRight: Radius.circular(0)),


    ),
    child: DropdownButton<String>(
      style: TextStyle(fontSize: 15, color: Colors.black),
      value: value,
      onChanged: (val) {
        onChange(val);
      },
      items: items.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem(
          child: Text(val),
          value: val,

        );
      }).toList(),
    ),
  );
}
