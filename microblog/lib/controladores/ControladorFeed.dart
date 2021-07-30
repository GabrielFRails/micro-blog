import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/servicos/ServicosDoMicroBlog.dart';
import 'package:microblog/util/StatusConculta.dart';
import 'package:mobx/mobx.dart';
part 'ControladorFeed.g.dart';

class ControladorFeed = _ControladorFeedBase with _$ControladorFeed;

abstract class _ControladorFeedBase with Store {
  ServicosDoMicroBlog mService = GetIt.I.get<ServicosDoMicroBlog>();

  @observable
  ObservableList<Postagem> mPostagens = ObservableList<Postagem>();

  @observable
  StatusConsulta mStatusConsultaFeed = StatusConsulta.CARREGANDO;

  @observable
  String conteudoPublicacao = "";

  @computed
  bool get habilitadoAPostar => conteudoPublicacao.isNotEmpty;

  void consultarFeed(
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    mStatusConsultaFeed = StatusConsulta.CARREGANDO;
    mService.consultarPublicacoes().then((responseTodasPublicacoes) {
      mPostagens.clear();
      mPostagens.addAll(responseTodasPublicacoes.sucesso);
      mStatusConsultaFeed = StatusConsulta.SUCESSO;
      sucesso?.call();
    }).catchError((onError) {
      mStatusConsultaFeed = StatusConsulta.FALHA;
      erro?.call(onError.response.data["falha"]);
    });
  }

  void publicarPostagem(Postagem postagem,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    if (postagem == null) {
      postagem = Postagem(
          conteudo: conteudoPublicacao,
          criador: GetIt.I.get<ControladorUsuario>().mUsuarioLogado);
    } else {
      postagem.conteudo = conteudoPublicacao;
    }
    carregando?.call();
    mService.manterPublicacao(postagem).then((value) {
      if (postagem.id == null)
        mPostagens.insert(0, value.sucesso);
      else {
        var index = mPostagens.indexWhere((post) => post.id == postagem.id);
        mPostagens.removeAt(index);
        mPostagens.insert(index, value.sucesso);
      }
      conteudoPublicacao = "";
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
    });
  }

  void excluirPostagem(Postagem postagem,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    mService.removerPublicacao(postagem.id).then((value) {
      mPostagens.removeWhere((post) => post.id == postagem.id);
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
      mStatusConsultaFeed = StatusConsulta.FALHA;
    });
  }

  void darLikeNaPostagem(Postagem postagem,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    mService
        .darLikeNaPublicacao(
            GetIt.I.get<ControladorUsuario>().mUsuarioLogado, postagem.id)
        .then((value) {
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
    });
  }

  void removerLikeNaPostagem(Postagem postagem,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    mService
        .removerLike(
            postagem.id, GetIt.I.get<ControladorUsuario>().mUsuarioLogado.id)
        .then((value) {
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
    });
  }
}
