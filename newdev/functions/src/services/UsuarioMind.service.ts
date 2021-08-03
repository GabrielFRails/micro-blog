import {firestore} from "firebase-admin";
import {Request, Response} from "express";
import {ManterUsuarioMind} from "../model/ManterUsuarioMind";
import {HttpUtil} from "../Util/HttpUtil";

export class UsuarioMindService {
    private db: firestore.Firestore;

    constructor(db: firestore.Firestore) {
      this.db = db;
    }

    /**
     * O serviço cadastra o usuário, validando a sua existência
     */
    public cadastrarUsuario(request: Request, response: Response) {
      const usuarioMind: ManterUsuarioMind = ManterUsuarioMind.toManterUsuarioMind(request.body);

      if (usuarioMind.isUsuarioMindValido()) {
        this.db.collection("usuariosMindGabriel").where("email", "==", usuarioMind.email).get()
            .then((usuariosSnaps) => {
              if (usuariosSnaps.size === 0) {
                const id = this.db.collection("xis").doc().id;
                usuarioMind.id = id;
                return this.db.doc(`usuariosMindGabriel/${id}`).create(usuarioMind.toJson());
              } else {
                HttpUtil.falha("O usuário mind já existe, não é possível cadastrar", response);
                return null;
              }
            }).then((responseCriacaoUsuario) => {
              if (responseCriacaoUsuario !== null) {
                HttpUtil.sucesso(usuarioMind, response);
              }
            }).catch((erro) =>{
              HttpUtil.falha("Ops, tive uma falha" + erro, response);
            });
      } else {
        HttpUtil.falha("Usuário Mind Inválido", response);
      }
    }

    /**
     * logarUsuario permite fazer o login de um user, validando a sua existência
     */
    public logarUsuario(request: Request, response: Response) {
      const email = request.query.email;
      const senha = request.query.senha;

      if (email===null || email==="" || senha===null || senha==="") {
        HttpUtil.falha("Usuário ou senha incorretos/nulos", response);
      } else {
        this.db.collection("usuariosMindGabriel").where("email", "==", email).where("senha", "==", senha)
            .get().then((usuarioMindConsultaSnap) => {
              if (usuarioMindConsultaSnap.empty) {
                HttpUtil.falha("Usuário ou senha incorretos/nulos!", response);
              } else {
                const usuarioMind = ManterUsuarioMind.toManterUsuarioMind(usuarioMindConsultaSnap.docs[0].data());
                HttpUtil.sucesso(usuarioMind.toJson(), response);
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
      const usuarioMindEditar = ManterUsuarioMind.toManterUsuarioMind(request.body);
      if (usuarioMindEditar.isUsuarioMindValido() && usuarioMindEditar.id !== undefined && usuarioMindEditar.id !== "") {
        this.db.doc(`usuariosGabriel/${usuarioMindEditar.id}`).set(usuarioMindEditar.toJson())
            .then((resultadoSnap) => {
              HttpUtil.sucesso(usuarioMindEditar.toJson(), response);
            }).catch((erro) =>{
              HttpUtil.falha("Houve erro ao editar:" + erro, response);
            });
      } else {
        HttpUtil.falha("Usuário inválido", response);
      }
    }
}