import 'package:calculadora/interface.dart';
import 'package:calculadora/register_user.dart';
import 'package:flutter/material.dart';
import 'login_sing_in.dart';

void main() {
  runApp(LoginUser());
}

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  IngresoUsuarioEmail _ingresoUsuarioEmail = IngresoUsuarioEmail();
  String _respond;

  TextFormField inputData({TextEditingController input, String nameInput}) {
    return TextFormField(
      controller: input,
      decoration: InputDecoration(labelText: nameInput),
      obscureText: nameInput == 'Contraseña' ? true : false,
      validator: (value) {
        if (value.isEmpty) {
          return 'El campo esta vacio';
        }
        return null;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _respond = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
          child: Column(
        children: [
          inputData(input: _email, nameInput: 'Email'),
          inputData(input: _password, nameInput: 'Contraseña'),
          RaisedButton.icon(
              onPressed: () {
                _ingresoUsuarioEmail
                    .loginConEmail(
                        passwordValor: _password.text, emailValor: _email.text)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => calculadora(
                                title: value.email,
                              )));
                }).catchError((error) {
                  print('error login: $error');
                  setState(() {
                    _respond = error.toString();
                  });
                });
              },
              icon: Icon(Icons.input),
              label: Text('Login')),
          RaisedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterUser()));
              },
              icon: Icon(Icons.new_releases),
              label: Text('Registro')),
          _respond.isEmpty ? Container() : Text(_respond)
        ],
      )),
    );
  }
}
