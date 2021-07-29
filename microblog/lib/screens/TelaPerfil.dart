import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';

import '../controladores/ControladorUsuario.dart';
import '../model/Usuario.dart';

class TelaPerfil extends StatefulWidget {
  TelaPerfil({Key key}) : super(key: key);

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil>
    with AfterLayoutMixin<TelaPerfil> {
  BuildContext mMainContext;
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuarioLogado = GetIt.I.get<ControladorUsuario>().mUsuarioLogado;

  @override
  void initState() {
    mMainContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Este é o seu perfil"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controladorUsuario.logoutUsuario();
                  Navigator.pushReplacementNamed(context, "/splash");
                })
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [Text("Estes são os seus dados!")],
                      ))),
              Column(
                children: [
                  Text("Nome: ${_usuarioLogado.nome}"),
                  const SizedBox(height: 4),
                  Text("e-mail cadastrado: ${_usuarioLogado.email}")
                ],
              )
            ],
          ),
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }
}
