import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/DadosPerfilWidget.dart';
import 'package:microblog/util/PerfilWidget.dart';

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
      body: ListView(
        padding: EdgeInsets.all(25),
        physics: BouncingScrollPhysics(),
        children: [
          PerfilWidget(
            linkImagem:
                "https://i.pinimg.com/564x/2b/23/f6/2b23f6ee9fbc16112ac00b5c0d909959.jpg",
          ),
          const SizedBox(height: 24),
          buildNomeUsuario(_usuarioLogado),
          const SizedBox(height: 24),
          DadosPerfilWidget(),
          const SizedBox(height: 50),
          Center(
            child: Text("Zona de Perigo!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          Center(
            child: BotaoPadrao(
              background: Colors.redAccent,
              value: "Editar Perfil",
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget buildNomeUsuario(Usuario usuario) => Column(
        children: [
          Text(
            usuario.nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(usuario.email, style: TextStyle(color: Colors.grey)),
        ],
      );

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }
}
