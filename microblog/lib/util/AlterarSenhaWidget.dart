import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/TextFieldPadrao.dart';

class AlterarSenhaWidget extends StatefulWidget {
  final Usuario usuarioEditar;
  final Function() sucesso;
  const AlterarSenhaWidget({Key key, this.usuarioEditar, this.sucesso})
      : super(key: key);

  @override
  _AlterarSenhaWidgetState createState() => _AlterarSenhaWidgetState();
}

class _AlterarSenhaWidgetState extends State<AlterarSenhaWidget> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuarioLogado = GetIt.I.get<ControladorUsuario>().mUsuarioLogado;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldPadrao(
              titulo:
                  "Atenção ${_usuarioLogado.nome} você está alterando sua senha! Essa é a sua senha atual",
              value: _usuarioLogado.senha,
              onChanged: (text) {
                _usuarioLogado.senha = text;
              },
            ),
            Container(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Observer(builder: (_) {
                  return Container(
                      width: 100,
                      height: 30,
                      child: BotaoPadrao(
                          background: Colors.deepPurpleAccent,
                          value: "Editar",
                          onTap: () {
                            _controladorUsuario.editarUsuario(_usuarioLogado);
                            _controladorUsuario.logoutUsuario();
                            Navigator.pushReplacementNamed(context, "/splash");
                          }));
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
