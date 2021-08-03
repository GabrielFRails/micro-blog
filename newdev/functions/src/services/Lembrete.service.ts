import {firestore} from "firebase-admin";
import {Request, Response} from "express";
import {HttpUtil} from "../Util/HttpUtil";
import {Lembrete } from "../model/Lembrete";

export class LembreteService {
    private db: firestore.Firestore;

    constructor(db: firestore.Firestore){
        this.db = db;
    }

    public manterLembrete(request: Request, response: Response){
        if (request.body === undefined) {
            request.body = {};
        }

        const lembrete = Lembrete.toLembrete(request.body);

        if(lembrete.isValido()){
            if (lembrete.id === undefined || lembrete.id === null || lembrete.id === "null") {
                lembrete.id = this.db.collection("xis").doc().id;
                lembrete.dataLembrete = new Date();
              } else {
                lembrete.dataLembrete = undefined;
              }

              this.db.doc(`lembretesGabriel/${lembrete.id}`).set(lembrete.toJson(), {merge: true})
                 .then((resultadoSnap) => {
                    HttpUtil.sucesso(lembrete.toJson(), response);
                }).catch((erro) => {
                    HttpUtil.falha("Lembrete Inválido" + erro, response);
                });
        } else {
            HttpUtil.falha("Lembrete Inválido", response);
        }
    } 
    
    /**
     * exlcuirLembrete
     */
    public exlcuirLembrete(request: Request, response: Response) {
        if (request.query.id === undefined || request.query.id === "") {
            HttpUtil.falha("Lembrete Inválido", response);
          } else {
              this.db.doc(`lembretesGabriel/${request.query.id}`).delete().then((_) => {
                HttpUtil.sucesso("Lembrete excluído com sucesso", response);
              }).catch((erro) => {
                HttpUtil.falha("Ops! Ocorreu um erro na hora de excluir o seu lembrete!" + erro, response);
              });
          }
    }

    /**
     * listarLembretes
     */
    public listarLembretes(request: Request, response: Response) {
        this.db.collection("lembretesGabriel").orderBy("dataLembrete", "desc").get()
        .then((lembretesSnap) => {
            const listaDeLembretes: Lembrete[] = [];
            lembretesSnap.docs.forEach((lembreteSnap) => {
                listaDeLembretes.push(Lembrete.toLembrete(lembreteSnap.data()));
            });
            HttpUtil.sucesso(listaDeLembretes, response);
        }).catch((erro) => {
            HttpUtil.falha("Ops! Ocorreu um erro na hora de excluir o seu lembrete!" + erro, response);
        });
    }
}
