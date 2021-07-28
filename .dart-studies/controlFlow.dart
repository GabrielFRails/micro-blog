void main() {
  var anoAtual = 2021;
  var anoNascimento = 2001;

  if (anoAtual - anoNascimento >= 18) {
    print('Parabéns, você é de maior!');
  } else {
    print('Lhe falta ódio');
  }

  var amigos = ['Pedro', 'João', 'Lucas', 'Daniel'];

  for (var objeto in amigos) {
    print(objeto);
  }

  while (anoAtual > 2015) {
    print(anoAtual);
    anoAtual--;
  }
}
