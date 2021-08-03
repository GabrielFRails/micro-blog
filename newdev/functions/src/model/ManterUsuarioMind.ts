export class ManterUsuarioMind {
    nome?: string;
    email?: string;
    senha?: string;
    lembrete?: string;
    id?: string;
    constructor(nome?: string, email?: string, senha?: string, lembrete?: string, id?: string) {
      this.nome = nome;
      this.email = email;
      this.senha = senha;
      this.lembrete = lembrete;
      this.id = id;
    }

    public isUsuarioMindValido(): boolean {
      return this.email !== undefined && this.email !== "" && this.senha !== undefined && this.senha !== "";
    }

    static toManterUsuarioMind(json: any = {}): ManterUsuarioMind {
      return new ManterUsuarioMind(json.nome, json.email, json.senha, json.lembrete, json.id);
    }

    public toJson(): any {
      return JSON.parse(JSON.stringify(this));
    }
}

