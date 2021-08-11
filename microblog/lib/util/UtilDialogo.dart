//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorFeed.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/AlterarSenhaWidget.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/PublicacaoWidget.dart';

class UtilDialogo {
  static void exibirInformacao(BuildContext context,
      {String titulo, String mensagem}) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$titulo",
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  Text("$mensagem"),
                  SizedBox(
                    height: 16,
                  ),
                  BotaoPadrao(
                    value: "Ok, Entendido!",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void exibirPub(BuildContext mainContext, Postagem postagem) {
    ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
    showDialog(
      context: mainContext,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Atenção! Deseja excluir?"),
                  Divider(),
                  Text(
                    "${postagem.criador.nome}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text("${postagem.conteudo}"),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 35,
                    child: Row(
                      children: [
                        Expanded(
                          child: BotaoPadrao(
                            value: "Sim, quero excluir",
                            onTap: () {
                              _controladorFeed.excluirPostagem(
                                postagem,
                                carregando: () {
                                  Navigator.pop(mainContext);
                                  exibirLoading(mainContext);
                                },
                                sucesso: () {
                                  Navigator.pop(mainContext);
                                  exibirInformacao(mainContext,
                                      titulo: "Sucesso!",
                                      mensagem: "A Publicação Foi Excluída!");
                                },
                                erro: (mensagem) {
                                  Navigator.pop(mainContext);
                                  exibirInformacao(mainContext,
                                      titulo: "Ops!", mensagem: mensagem);
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: BotaoPadrao(
                            value: "Não, cancelar",
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void editarPub(BuildContext mainContext, Postagem postagem) {
    //ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
    showDialog(
      context: mainContext,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Atenção! você está editando"),
                  Divider(),
                  PublicacaoWidget(
                    postagemEditar: postagem,
                    sucesso: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void editarSenha(BuildContext mainContext, Usuario usuario) {
    //ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
    showDialog(
      context: mainContext,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Atenção! você está editando sua senha",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Divider(),
                  AlterarSenhaWidget(
                    usuarioEditar: usuario,
                    sucesso: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void exibirLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
