import * as functions from "firebase-functions";
import * as express from "express";
import * as admin from "firebase-admin";
import {UsuarioService} from "./services/Usuario.service";
import {PostagemService} from "./services/Postagem.service";

// Banco Firestore
admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

// Primeira Parte: Usuário

const usuarioExpressGabriel = express();
const usuarioService = new UsuarioService(db);

usuarioExpressGabriel.get("/servicoTeste", (req, res) => res.send("Teste feito com sucesso! Servidor rodando ok!"));

usuarioExpressGabriel.post("/cadastrarUsuario", (req, res) => usuarioService.cadastrarUsuario(req, res));

usuarioExpressGabriel.get("/logarUsuario", (req, res) => usuarioService.logarUsuario(req, res));

usuarioExpressGabriel.post("/editarUsuario", (req, res) => usuarioService.editarUsuario(req, res));

export const usuarioGabriel = functions.https.onRequest(usuarioExpressGabriel);

// Segunda Parte: Posts

const postagemExpressGabriel = express();
const postagemService = new PostagemService(db);

postagemExpressGabriel.post("/manterPostagem", (req, res) => postagemService.manterPostagem(req, res));

postagemExpressGabriel.post("/comentarPostagem", (req, res) => postagemService.comentaPublicacao(req, res));

postagemExpressGabriel.get("/excluirPostagem", (req, res) => postagemService.excluirPostagem(req, res));

postagemExpressGabriel.get("/excluirComentario", (req, res) => postagemService.excluirComentario(req, res));

postagemExpressGabriel.post("/darLike", (req, res) => postagemService.darLikeNoPost(req, res));

postagemExpressGabriel.get("/removerLike", (req, res) => postagemService.removerLikeDoPost(req, res));

postagemExpressGabriel.get("/consultarPublicacoes", (req, res) => postagemService.listaPublicacoes(req, res));

export const feedGabriel = functions.https.onRequest(postagemExpressGabriel);
