import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/UtilDataHora.dart';
part 'Postagem.g.dart';

@JsonSerializable()
class Postagem {
  String id, conteudo;
  @JsonKey(fromJson: UtilDataHora.convertStringToDate)
  DateTime dataPostagem;
  Usuario criador;
  List<Usuario> likes;

  bool get isCriador =>
      GetIt.I.get<ControladorUsuario>().mUsuarioLogado.id.contains(criador.id);

  Postagem({this.conteudo, this.criador, this.dataPostagem, this.id});

  factory Postagem.fromJson(Map<String, dynamic> json) =>
      _$PostagemFromJson(json);
  Map<String, dynamic> toJson() => _$PostagemToJson(this);
}

@JsonSerializable()
class Comentario {
  Comentario({this.comentario, this.criador, this.dataComentario, this.id});

  String comentario, id;
  @JsonKey(fromJson: UtilDataHora.convertStringToDate)
  DateTime dataComentario;
  Usuario criador;

  factory Comentario.fromJson(Map<String, dynamic> json) =>
      _$ComentarioFromJson(json);
  Map<String, dynamic> toJson() => _$ComentarioToJson(this);
}
