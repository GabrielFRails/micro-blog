import {ManterUsuario} from "./ManterUsuario";

export class Postagem {
    id?: string;
    conteudo?: string;
    dataPostagem?: Date;
    criador?: ManterUsuario;
    likes?: ManterUsuario[];
    comentarios?: Comentario[];

    constructor(id?: string, conteudo?: string, dataPostagem?: Date, criador?: ManterUsuario, likes?: ManterUsuario[], comentarios?: Comentario[]) {
      this.id = id;
      this.conteudo = conteudo;
      this.dataPostagem = dataPostagem;
      this.criador = criador;
      this.likes = likes;
      this.comentarios = comentarios;
    }

    public isValida(): boolean {
      return this.conteudo !== undefined && this.criador !== undefined;
    }

    static toPostagem(json: any): Postagem {
      return new Postagem(json.id, json.conteudo, new Date(json.dataPostagem), ManterUsuario.toManterUsuario(json.criador), json.likes, json.comentarios);
    }

    public toJson(): any {
      return JSON.parse(JSON.stringify(this));
    }
}

export class Comentario {
    dataDoComentario?: Date;
    comentario?: string;
    criador?: ManterUsuario;
    id?: string;

    constructor(criador?: ManterUsuario, comentario?: string, dataComentario?: Date, id?: string) {
      this.comentario = comentario;
      this.dataDoComentario = dataComentario;
      this.criador = criador;
      this.id = id;
    }

    public isValido(): boolean {
      return this.criador !== undefined && this.comentario !== undefined && this.comentario !== "";
    }

    static toComentario(json: any): Comentario {
      return new Comentario(ManterUsuario.toManterUsuario(json.criador), json.comentario, json.dataDoComentario, json.id);
    }

    public toJson(): any {
      return JSON.parse(JSON.stringify(this));
    }
}
