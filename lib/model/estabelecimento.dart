class Estabelecimento {
  String _nome;
  String _cidade;
  String _foto;


  Estabelecimento(this._nome, this._cidade, this._foto);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cidade => _cidade;

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }

  set cidade(String value) {
    _cidade = value;
  }


}