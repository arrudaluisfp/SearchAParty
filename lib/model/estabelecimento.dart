class Estabelecimento {
  String _nome;
  String _cidade;
  String _foto;
  String _descricao;
  String _telefone;
  String _endereco;
  String _categoria;


  Estabelecimento(this._nome, this._cidade, this._foto, this._descricao, this._telefone, this._endereco, this._categoria);

  String get nome => _nome;


  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

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

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }


}