import {firestore} from "firebase-admin";
import {Request, Response} from "express";
import {ManterUsuario} from "../model/ManterUsuario";
import {HttpUtil} from "../Util/HttpUtil";

export class UsuarioService {
    private db: firestore.Firestore;

    constructor(db: firestore.Firestore) {
      this.db = db;
    }

    /**
     * O serviço cadastra o usuário, validando a sua existência
     */
    public cadastrarUsuario(request: Request, response: Response) {
      const usuario: ManterUsuario = ManterUsuario.toManterUsuario(request.body);

      if (usuario.isUsuarioValido()) {
        this.db.collection("usuariosGabriel").where("email", "==", usuario.email).get()
            .then((usuariosSnaps) => {
              if (usuariosSnaps.size === 0) {
                const id = this.db.collection("xis").doc().id;
                usuario.id = id;
                return this.db.doc(`usuariosGabriel/${id}`).create(usuario.toJson());
              } else {
                HttpUtil.falha("O usuário já existe, não é possível cadastrar", response);
                return null;
              }
            }).then((responseCriacaoUsuario) => {
              if (responseCriacaoUsuario !== null) {
                HttpUtil.sucesso(usuario, response);
              }
            }).catch((erro) =>{
              HttpUtil.falha("Ops, tive uma falha" + erro, response);
            });
      } else {
        HttpUtil.falha("Usuário Inválido", response);
      }
    }

    /**
     * logarUsuario permite fazer o login de um user, validando a sua existência
     */
    public logarUsuario(request: Request, response: Response) {
      const email = request.query.email;
      const senha = request.query.senha;

      if (email===null || email==="" || senha===null || senha==="") {
        HttpUtil.falha("Usuário ou senha incorretos", response);
      } else {
        this.db.collection("usuariosGabriel").where("email", "==", email).where("senha", "==", senha)
            .get().then((usuarioConsultaSnap) => {
              if (usuarioConsultaSnap.empty) {
                HttpUtil.falha("Usuário ou senha incorretos!", response);
              } else {
                const usuario = ManterUsuario.toManterUsuario(usuarioConsultaSnap.docs[0].data());
                HttpUtil.sucesso(usuario.toJson(), response);
              }
            }).catch((erro) =>{
              HttpUtil.falha("Ops! Tive um erro no login: " + erro, response);
            });
      }
    }

    /**
     * editarUsuario
     */
    public editarUsuario(request: Request, response: Response) {
      const usuarioEditar = ManterUsuario.toManterUsuario(request.body);
      if (usuarioEditar.isUsuarioValido() && usuarioEditar.id !== undefined && usuarioEditar.id !== "") {
        this.db.doc(`usuariosGabriel/${usuarioEditar.id}`).set(usuarioEditar.toJson())
            .then((resultadoSnap) => {
              HttpUtil.sucesso(usuarioEditar.toJson(), response);
            }).catch((erro) =>{
              HttpUtil.falha("Houve erro ao editar:" + erro, response);
            });
      } else {
        HttpUtil.falha("Usuário inválido", response);
      }
    }
}
