import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/TextFieldPadrao.dart';
import 'package:microblog/util/UtilDialogo.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("login no Micro-blog"),
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
                              sucesso: () {
                                Navigator.pushReplacementNamed(
                                    context, "/telaPrincipal");
                              },
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
