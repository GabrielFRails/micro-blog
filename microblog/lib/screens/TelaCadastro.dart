import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/TextFieldPadrao.dart';
import 'package:microblog/util/UtilDialogo.dart';

class TelaDeCadastro extends StatefulWidget {
  TelaDeCadastro({Key key}) : super(key: key);

  @override
  _TelaDeCadastroState createState() => _TelaDeCadastroState();
}

class _TelaDeCadastroState extends State<TelaDeCadastro> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro no Micro-blog"),
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
                      Text("Faça Já o seu Cadastro!"),
                      Divider(),
                      TextFieldPadrao(
                        titulo: "E-mail",
                        onChanged: (text) {
                          _usuario.email = text;
                        },
                      ),
                      TextFieldPadrao(
                        titulo: "Nome",
                        onChanged: (text) {
                          _usuario.nome = text;
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
                          value: "Me Registrar",
                          onTap: () {
                            _controladorUsuario.cadastrarUsuario(
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
