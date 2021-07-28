import 'package:microblog/model/Postagem.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/UtilRetorno.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'ServicosDoMicroBlog.g.dart';

@RestApi(baseUrl: "https://us-central1-meu-blog-curso.cloudfunctions.net")
abstract class ServicosDoMicroBlog {
  factory ServicosDoMicroBlog(Dio dio, {String baseUrl}) = _ServicosDoMicroBlog;

  //Parte Serviços do Usuário

  @POST("/usuarioGabriel/cadastrarUsuario")
  Future<UtilRetornoUsuario> cadastrarUsuario(@Body() Usuario usuario);

  @GET("/usuarioGabriel/logarUsuario")
  Future<UtilRetornoUsuario> logarUsuario(
      @Query("email") String email, @Query("senha") String senha);

  @POST("/usuarioGabriel/editarUsuario")
  Future<UtilRetornoUsuario> editarUsuario(@Body() Usuario usuario);

  //Parte Serviços do Feed
  @POST("/feedGabriel/manterPostagem")
  Future<UtilRetornoPostagem> manterPublicacao(@Body() Postagem postagem);

  @GET("/feedGabriel/comentarPostagem")
  Future<UtilRetornoPostagem> comentarPublicacao(
      @Body() Comentario comentario, @Query("id") String id);

  @GET("/feedGabriel/excluirComentario")
  Future<UtilRetornoPostagem> excluirComentario(
      @Query("id") String idPost, @Query("idComentario") String idComentario);

  @GET("/feedGabriel/excluirPostagem")
  Future<UtilRetornoPostagem> removerPublicacao(@Query("id") String id);

  @POST("/feedGabriel/darLike")
  Future<UtilRetornoPostagem> darLikeNaPublicacao(
      @Body() Usuario usuario, @Query("id") String idDaPublicacao);

  @GET("/feedGabriel/removerLike")
  Future<UtilRetornoUsuario> removerLike(
      @Query("id") String idPublicacao, @Query("idUsuario") String idUsuario);

  @GET("/feedGabriel/consultarPublicacoes")
  Future<UtilRetornoPublicacoes> consultarPublicacoes();
  //@GET("/tasks")
  //Future<List<Task>> getTasks();
}
