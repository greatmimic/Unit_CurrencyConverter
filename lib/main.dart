
import 'package:flutter/material.dart';
import 'package:simply_converted/tabs/Home.dart';



void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal,
    fontFamily: 'RopaSans'),
    initialRoute: '/home',
    routes: {

      '/home': (context) => Home(),


    },

  ));


