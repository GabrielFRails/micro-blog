import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/servicos/ServicosDoMicroBlog.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'ControladorUsuario.g.dart';

class ControladorUsuario = _ControladorUsuarioBase with _$ControladorUsuario;

abstract class _ControladorUsuarioBase with Store {
  Usuario mUsuarioLogado;
  ServicosDoMicroBlog mService = GetIt.I.get<ServicosDoMicroBlog>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void verificarSeTemUsuario(
      {Function() temUsuario, Function() naoTemUsuario}) {
    _prefs.then((db) {
      var usuarioJson = db.getString("user");
      if (usuarioJson != null) {
        mUsuarioLogado = Usuario.fromJson(JsonCodec().decode(usuarioJson));
        temUsuario?.call();
      } else {
        naoTemUsuario?.call();
      }
    });
  }

  void logoutUsuario() {
    _prefs.then((db) {
      db.remove("user");
    });
  }

  void cadastrarUsuario(Usuario usuarioCadastrar,
      {Function() sucesso, Function(String mensagem) erro}) {
    if (usuarioCadastrar.email?.isEmpty ?? true) {
      erro?.call("E-mail Inválido");
    } else if (usuarioCadastrar.senha?.isEmpty ?? true) {
      erro?.call("Senha Inválida");
    } else if (usuarioCadastrar.nome?.isEmpty ?? true) {
      erro?.call("Defina seu nome");
    } else {
      mService.cadastrarUsuario(usuarioCadastrar).then((usuario) {
        _prefs.then((db) {
          db.setString("user", JsonCodec().encode(usuario.sucesso.toJson()));
          mUsuarioLogado = usuario.sucesso;
          sucesso?.call();
        });
      }).catchError((onError) {
        erro?.call(onError.response.data["falha"]);
      });
    }
  }

  void editarUsuario(Usuario usuarioEditar,
      {Function() sucesso, Function(String mensagem) erro}) {
    mService.editarUsuario(usuarioEditar).then((usuario) {
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
    });
  }

  void logarUsuario(Usuario usuarioLogar,
      {Function() sucesso, Function(String mensagem) erro}) {
    if ((usuarioLogar.email?.isEmpty ?? true) ||
        (usuarioLogar.senha?.isEmpty ?? true)) {
      erro?.call("Usuário ou Senha Inválidos");
    } else {
      mService
          .logarUsuario(usuarioLogar.email, usuarioLogar.senha)
          .then((usuario) {
        _prefs.then((db) {
          db.setString("user", JsonCodec().encode(usuario.sucesso.toJson()));
          mUsuarioLogado = usuario.sucesso;
          sucesso?.call();
        });
      }).catchError((onError) {
        erro?.call(onError.response.data["falha"]);
      });
    }
  }
}
