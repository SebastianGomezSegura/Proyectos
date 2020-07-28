import 'package:calculadora/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'main.dart';

class calculadora extends StatefulWidget {
  calculadora({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _calculadoraState createState() => _calculadoraState();
}

class _calculadoraState extends State<calculadora> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 50.0;
  double resultFontSize = 50.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        double equationFontSize = 50.0;
        double resultFontSize = 50.0;
      } else if (buttonText == "DEL") {
        equation = equation.substring(0, equation.length - 1);
        double equationFontSize = 50.0;
        double resultFontSize = 50.0;
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        double equationFontSize = 50.0;
        double resultFontSize = 50.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.transparent, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: 150.0,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.grey,
                    Colors.white70,
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Image.asset(
                          "assets/images/calculadora.png",
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Text(
                        'CALCULADORA',
                        style: TextStyle(color: Colors.black, fontSize: 10.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            List(
                Icons.dehaze,
                'Historial',
                () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Historial()))),
            List(Icons.delete, 'Borrar Historial', () => {}),
            List(
                Icons.person,
                'Cerrar Sesión',
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Splash()))),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 40, 5, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 5, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.black),
                        buildButton("DEL", 1, Colors.black),
                        buildButton("/", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black),
                        buildButton("8", 1, Colors.black),
                        buildButton("9", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black),
                        buildButton("5", 1, Colors.black),
                        buildButton("6", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("3", 1, Colors.black),
                        buildButton("2", 1, Colors.black),
                        buildButton("1", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black),
                        buildButton("0", 1, Colors.black),
                        buildButton("00", 1, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("x", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class List extends StatelessWidget {
  IconData icon;
  String text;
  Function onPressed;
  List(this.icon, this.text, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.black12,
          onTap: onPressed,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
