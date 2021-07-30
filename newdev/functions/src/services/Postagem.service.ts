import {firestore} from "firebase-admin";
import {Request, Response} from "express";
import {HttpUtil} from "../Util/HttpUtil";
import {Comentario, Postagem} from "../model/Postagem";
import {ManterUsuario} from "../model/ManterUsuario";

export class PostagemService {
    private db: firestore.Firestore;

    constructor(db: firestore.Firestore) {
      this.db = db;
    }

    /**
     *  Realiza/edita uma Postagem
     */
    public manterPostagem(request: Request, response: Response) {
      // Aula 11 - 13 minutos
      if (request.body === undefined) {
        request.body = {};
      }

      const postagem = Postagem.toPostagem(request.body);

      if (postagem.isValida()) {
        if (postagem.id === undefined || postagem.id === null || postagem.id === "null") {
          postagem.id = this.db.collection("xis").doc().id;
          postagem.dataPostagem = new Date();
        } else {
          postagem.dataPostagem = undefined;
        }

        this.db.doc(`publicacoesGabriel/${postagem.id}`).set(postagem.toJson(), {merge: true})
            .then((resultadoSnap) => {
              HttpUtil.sucesso(postagem.toJson(), response);
            }).catch((erro) => {
              HttpUtil.falha("Postagem Inválida" + erro, response);
            });
      } else {
        HttpUtil.falha("Postagem Inválida", response);
      }
    }

    /**
     * comentaPublicacao
     */
    public comentaPublicacao(request: Request, response: Response) {
      const idPostagem = request.query.id;
      const comentario = Comentario.toComentario(request.body);
      let post: Postagem;
      if (idPostagem === undefined || idPostagem === "") {
        HttpUtil.falha("O id não pode ser nulo ou vazio!", response);
      } else if (!comentario.isValido()) {
        HttpUtil.falha("O comentário deve ser preenchido!", response);
      } else {
        this.db.doc(`publicacoesGabriel/${idPostagem}`).get()
            .then((postSnap) => {
              post = Postagem.toPostagem(postSnap.data());
              comentario.dataDoComentario = new Date();
              comentario.id = this.db.collection("xis").doc().id;
              if (post.comentarios === undefined) post.comentarios = [];
              post.comentarios.push(comentario);
              return postSnap.ref.set(post.toJson(), {merge: true});
            }).then((_) => {
              HttpUtil.sucesso(post.toJson(), response);
            }).catch((erro) =>{
              HttpUtil.falha("Ouve umna falha ao tentar inserir um comentário" + erro, response);
            });
      }
    }

    /**
     * excluirPostagem
     */
    public excluirPostagem(request: Request, response: Response) {
      if (request.query.id === undefined || request.query.id === "") {
        HttpUtil.falha("Post Inválido", response);
      } else {
        this.db.doc(`publicacoesGabriel/${request.query.id}`).delete().then((_) =>{
          HttpUtil.sucesso("Post Excluído com sucesso", response);
        }).catch((erro) => {
          HttpUtil.falha("Ops! Ocorreu um erro!" + erro, response);
        });
      }
    }

    /**
     * excluirPostagem
     */
    public excluirComentario(request: Request, response: Response) {
      const idPostagem = request.query.id;
      const idComentario = request.query.idComentario;
      let postagem: Postagem;
      if (idPostagem === undefined || idPostagem === "" || idComentario === undefined || idComentario === "") {
        HttpUtil.falha("Post ou Comentário Inválido!", response);
      } else {
        this.db.doc(`publicacoesGabriel/${idPostagem}`).get().then((postSnap) => {
          postagem = Postagem.toPostagem(postSnap.data());
          postagem.comentarios = postagem.comentarios?.filter((c) => c.id !== idComentario);
          return postSnap.ref.set(postagem.toJson());
        }).then((_) => {
          HttpUtil.sucesso(postagem.toJson(), response);
        }).catch((erro) => {
          HttpUtil.falha("Ops! Houve um erro inesperado" + erro, response);
        });
      }
    }

    /**
     * darLikeNoPost
     */
    public darLikeNoPost(request: Request, response: Response) {
      const idPostagem = request.query.id;
      const like = ManterUsuario.toManterUsuario(request.body);
      let postagem: Postagem;
      if (idPostagem === undefined || idPostagem === "" || like === undefined) {
        HttpUtil.falha("O Like não pode ser dado pois o id está vazio", response);
      } else {
        this.db.doc(`publicacoesGabriel/${idPostagem}`).get().then((postSnap) => {
          postagem = Postagem.toPostagem(postSnap.data());
          if (postagem.likes === undefined || postagem.likes === null) postagem.likes = [];
          postagem.likes.push(like);
          return postSnap.ref.set(postagem.toJson());
        }).then((_) => {
          HttpUtil.sucesso(postagem.toJson(), response);
        }).catch((erro) => {
          HttpUtil.falha("Ops! Houve um erro inesperado" + erro, response);
        });
      }
    }

    /**
     * retirarLikeDoPost
     */
    public removerLikeDoPost(request: Request, response: Response) {
      const idPostagem = request.query.id;
      const idUsuario = request.query.idUsuario;
      let postagem: Postagem;
      if (idPostagem === undefined || idPostagem === "" || idUsuario === undefined || idUsuario === "") {
        HttpUtil.falha("Não é possíver remover o like, falta id da publicação ou id do usuário", response);
      } else {
        this.db.doc(`publicacoesGabriel/${idPostagem}`).get().then((postSnap) => {
          postagem = Postagem.toPostagem(postSnap.data());
          postagem.likes = postagem.likes?.filter((l) => l.id !== idUsuario);
          return postSnap.ref.set(postagem.toJson());
        }).then((_) => {
          HttpUtil.sucesso(postagem.toJson(), response);
        }).catch((erro) => {
          HttpUtil.falha("Ops! Houve um erro inesperado" + erro, response);
        });
      }
    }

    /**
     * listaPublicacoes
     */
    public listaPublicacoes(request: Request, response: Response) {
      this.db.collection("publicacoesGabriel").orderBy("dataPostagem", "desc").get().then((postagensSnap) => {
        const listaPublicacoes: Postagem[] = [];
        postagensSnap.docs.forEach((postSnap) => {
          listaPublicacoes.push(Postagem.toPostagem(postSnap.data()));
        });
        HttpUtil.sucesso(listaPublicacoes, response);
      }).catch((erro) => {
        HttpUtil.falha("Ops! Houve um erro inesperado" + erro, response);
      });
    }
}
