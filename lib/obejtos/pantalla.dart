import 'package:flutter/material.dart';

class Pantalla extends StatefulWidget {

static const String idPan = "pantalla";
  @override
  _PantallaState createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("S.R.A.P"),
      ),
    );
  }
}