import 'package:calculadora/interface.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_sing_in.dart';

class RegisterUser extends StatefulWidget {
  static TextEditingController _name = TextEditingController();
  static TextEditingController _password = TextEditingController();
  static TextEditingController _email = TextEditingController();
  static GlobalKey<FormState> _form = GlobalKey<FormState>();

  static CrearUsuario _createUser = CrearUsuario();
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  int _characterMin;

  TextFormField inputData({TextEditingController input, String nameInput}) {
    return TextFormField(
      controller: input,
      decoration: InputDecoration(
          labelText: nameInput, counterText: _characterMin.toString()),
      onChanged: (value) {
        print(value);
        setState(() {
          if (nameInput == 'Contraseña') _characterMin = value.length;
        });
      },
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
    _characterMin = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuario'),
      ),
      body: Scrollable(viewportBuilder: (context, data) {
        return Form(
            key: RegisterUser._form,
            child: Column(
              children: [
                inputData(nameInput: 'Nombre', input: RegisterUser._name),
                inputData(nameInput: 'Email', input: RegisterUser._email),
                inputData(
                    nameInput: 'Contraseña', input: RegisterUser._password),
                RaisedButton.icon(
                    onPressed: () {
                      if (RegisterUser._form.currentState.validate() &&
                          _characterMin >= 8) {
                        RegisterUser._createUser
                            .uidUsuarioCreado(
                                emailValor: RegisterUser._email.text,
                                passwordValor: RegisterUser._password.text)
                            .then((value) {
                          Firestore.instance
                              .collection('user')
                              .document(value)
                              .setData({
                            'name_complete': RegisterUser._name.text,
                            'email': RegisterUser._email.text
                          }).whenComplete(() {
                            RegisterUser._name.clear();
                            RegisterUser._email.clear();
                            RegisterUser._password.clear();
                          }).then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => calculadora())));
                        });
                      } else {
                        if (_characterMin < 8) {
                          print('El password es menor 8');
                        }
                      }
                    },
                    icon: Icon(Icons.input),
                    label: Text('Registrar'))
              ],
            ));
      }),
    );
  }
}
