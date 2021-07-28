import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/TextFieldPadrao.dart';
import 'package:microblog/util/UtilDialogo.dart';

class TelaErroPush extends StatefulWidget {
  const TelaErroPush({Key key}) : super(key: key);

  @override
  _TelaErroPushState createState() => _TelaErroPushState();
}

class _TelaErroPushState extends State<TelaErroPush> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Erro"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
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
                    children: [
                      Text("Faça já o seu login"),
                      Divider(),
                      TextFieldPadrao(
                        titulo: "Usuário",
                        onChanged: (text) {
                          _usuario.email = text;
                        },
                      ),
                      TextFieldPadrao(
                        titulo: "Senha",
                        obscureText: true,
                        onChanged: (text) {
                          _usuario.senha = text;
                        },
                      ),
                      Container(),
                      BotaoPadrao(
                          background: Colors.deepPurpleAccent,
                          value: "Entrar",
                          onTap: () {
                            _controladorUsuario.logarUsuario(
                              _usuario,
                              sucesso: () {},
                              erro: (mensagem) {
                                UtilDialogo.exibirInformacao(context,
                                    titulo: "Ops!", mensagem: mensagem);
                              },
                            );
                          }),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Text("Ou"),
                          Expanded(child: Divider())
                        ],
                      ),
                      BotaoPadrao(
                          background: Colors.deepPurpleAccent,
                          value: "Quero Me Cadastrar",
                          onTap: () {
                            Navigator.pushNamed(context, "/telaDeCadastro");
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
