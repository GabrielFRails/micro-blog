// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServicosDoMicroBlog.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ServicosDoMicroBlog implements ServicosDoMicroBlog {
  _ServicosDoMicroBlog(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://us-central1-meu-blog-curso.cloudfunctions.net';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<UtilRetornoUsuario> cadastrarUsuario(usuario) async {
    ArgumentError.checkNotNull(usuario, 'usuario');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(usuario?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/usuarioGabriel/cadastrarUsuario',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoUsuario.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoUsuario> logarUsuario(email, senha) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(senha, 'senha');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'email': email, r'senha': senha};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/usuarioGabriel/logarUsuario',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoUsuario.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoUsuario> editarUsuario(usuario) async {
    ArgumentError.checkNotNull(usuario, 'usuario');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(usuario?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/usuarioGabriel/editarUsuario',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoUsuario.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoPostagem> manterPublicacao(postagem) async {
    ArgumentError.checkNotNull(postagem, 'postagem');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postagem?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/manterPostagem',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoPostagem.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoPostagem> comentarPublicacao(comentario, id) async {
    ArgumentError.checkNotNull(comentario, 'comentario');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    _data.addAll(comentario?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/comentarPostagem',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoPostagem.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoPostagem> excluirComentario(idPost, idComentario) async {
    ArgumentError.checkNotNull(idPost, 'idPost');
    ArgumentError.checkNotNull(idComentario, 'idComentario');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': idPost,
      r'idComentario': idComentario
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/excluirComentario',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoPostagem.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoPostagem> removerPublicacao(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/excluirPostagem',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoPostagem.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoPostagem> darLikeNaPublicacao(
      usuario, idDaPublicacao) async {
    ArgumentError.checkNotNull(usuario, 'usuario');
    ArgumentError.checkNotNull(idDaPublicacao, 'idDaPublicacao');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': idDaPublicacao};
    final _data = <String, dynamic>{};
    _data.addAll(usuario?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/darLike',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoPostagem.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoUsuario> removerLike(idPublicacao, idUsuario) async {
    ArgumentError.checkNotNull(idPublicacao, 'idPublicacao');
    ArgumentError.checkNotNull(idUsuario, 'idUsuario');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': idPublicacao,
      r'idUsuario': idUsuario
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/removerLike',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoUsuario.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilRetornoPublicacoes> consultarPublicacoes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/feedGabriel/consultarPublicacoes',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilRetornoPublicacoes.fromJson(_result.data);
    return value;
  }
}
