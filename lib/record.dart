import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Historial extends StatefulWidget {
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HISTORIAL"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Text(
              "null",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ],
      ),
    );
  }
}
