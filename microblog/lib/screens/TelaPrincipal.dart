import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:like_button/like_button.dart';
import 'package:microblog/controladores/ControladorFeed.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/PublicacaoWidget.dart';
import 'package:microblog/util/StatusConculta.dart';
import 'package:microblog/util/UtilDataHora.dart';
import 'package:microblog/util/UtilDialogo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal>
    with AfterLayoutMixin<TelaPrincipal> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
  BuildContext mMainContext;
  Usuario _usuarioLogado = GetIt.I.get<ControladorUsuario>().mUsuarioLogado;

  @override
  void initState() {
    mMainContext = context;
    super.initState();
  }

  _consultarFeed() {
    _controladorFeed.consultarFeed(sucesso: () {
      Navigator.pop(context);
      _refreshController.refreshCompleted();
    }, erro: (mensagem) {
      Navigator.pop(context);
      _refreshController.refreshFailed();
    }, carregando: () {
      UtilDialogo.exibirLoading(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Bem vindo/a Homo Sapiens"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/telaPerfil");
              })
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        onRefresh: _consultarFeed,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              PublicacaoWidget(),
              Observer(
                builder: (_) {
                  switch (_controladorFeed.mStatusConsultaFeed) {
                    case StatusConsulta.CARREGANDO:
                      return Text("Aguarde, estou consultando");
                      break;
                    case StatusConsulta.SUCESSO:
                      return ListView.builder(
                        primary: false,
                        itemBuilder: (context, index) {
                          var post = _controladorFeed.mPostagens[index];
                          bool isPostLike;
                          int quantidadeLikes;
                          if (post.likes == null) {
                            isPostLike = false;
                            quantidadeLikes = 0;
                          } else if (post.likes.indexWhere(
                                  (like) => like.id == _usuarioLogado.id) ==
                              -1) {
                            isPostLike = false;
                            quantidadeLikes = post.likes.length;
                          } else if (post.likes.indexWhere(
                                  (like) => like.id == _usuarioLogado.id) !=
                              -1) {
                            isPostLike = true;
                            quantidadeLikes = post.likes.length;
                          } else if (post.likes.length > 0) {
                            isPostLike = true;
                            quantidadeLikes = post.likes.length;
                          }
                          return Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${post.criador.nome}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Visibility(
                                      visible: post.isCriador,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              UtilDialogo.editarPub(
                                                  mMainContext, post);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              UtilDialogo.exibirPub(
                                                  mMainContext, post);
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Text("${post.conteudo}"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LikeButton(
                                        size: 35,
                                        isLiked: isPostLike,
                                        likeCount: quantidadeLikes,
                                        onTap: (isLiked) async {
                                          if (isLiked == false) {
                                            _controladorFeed
                                                .darLikeNaPostagem(post);
                                            //_consultarFeed();
                                          } else {
                                            _controladorFeed
                                                .removerLikeNaPostagem(post);
                                            //_consultarFeed();
                                          }
                                          return !isLiked;
                                        },
                                      ),
                                      Container(),
                                      Text(UtilDataHora.converteDateTime(
                                          post.dataPostagem))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                        },
                        itemCount: _controladorFeed.mPostagens.length,
                        shrinkWrap: true,
                      );

                      break;
                    case StatusConsulta.FALHA:
                      return Text("Ops! N??o consegui carregar");
                      break;
                    default:
                      return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _consultarFeed();
  }
}
