import {ManterUsuario} from "./ManterUsuario";

export class Lembrete {
    id?: string;
    titulo?: string;
    conteudo?: string;
    emocao?: string;
    dataLembrete?: Date;
    criador?: ManterUsuario;
    

    constructor(id?: string, titulo?: string, conteudo?: string, emocao?: string, dataLembrete?: Date, criador?: ManterUsuario) {
      this.id = id;
      this.conteudo = conteudo;
      this.emocao = emocao;
      this.dataLembrete = dataLembrete;
      this.criador = criador;
      
    }

    public isValido(): boolean {
      return this.conteudo !== undefined && this.criador !== undefined;
    }

    public isEmocaoValida(): boolean {
      switch (this.emocao) {
        case "ALEGRIA":
          return true;
        case "TRISTEZA":
          return true;
        case "MEDO":
          return true;
        case "NOJO":
          return true;
        case "RAIVA":
          return true;
        default:
          return false;
      }
    }

    static toLembrete(json: any): Lembrete {
      return new Lembrete(json.id, json.titulo, json.conteudo, json.emocao, new Date(json.dataLembrete), ManterUsuario.toManterUsuario(json.criador));
    }

    public toJson(): any {
      return JSON.parse(JSON.stringify(this));
    }
}
