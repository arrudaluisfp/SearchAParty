import 'package:com/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:com/pages/home.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _nomeController  = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  String _erroMsg = "";

  _validacao() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (nome.isNotEmpty || email.isNotEmpty || senha.isNotEmpty) {
      if(!email.contains("@")) {
        setState(() {
          _erroMsg = "Informe um e-mail válido!";
        });
      } else if (!(senha.length > 6)) {
        setState(() {
          _erroMsg = "Senha deve ter mais de 6 caracteres!";
        });
      } else {
        setState(() {
          _erroMsg = "";
        });

        Usuario usuario = Usuario();
        usuario.nome = nome;
        usuario.email = email;
        usuario.senha = senha;

        _cadastrar(usuario);
      }
    } else {
      setState(() {
        _erroMsg = "Preencha todos os campos";
      });
    }
  }

  _cadastrar(Usuario usuario) {

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
    ).then((firebaseUser) {
      // Se usuário cadastrado, loga no sistema
      _erroMsg = "CADASTRO REALIZADO COM SUCESSO!";
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print("Erro retornado do Firebase: "+error.toString());
      setState(() {
        _erroMsg = "Erro ao cadastrar o usuário. Confirme os dados informados!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage( //FUNDO
              image: AssetImage("assets/images/imagemFundo.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:50, left:150,right:150),
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),

            Padding( //NOME COMPLETO
              padding: EdgeInsets.only(top:40, left:30, right:30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width:0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical:5.0, horizontal:20.0),
                  filled: true, //preenchivel
                  fillColor: Colors.white, //na cor branca
                  alignLabelWithHint: true, //alinha o que ta dentro
                  hintText: 'Nome Completo',
                ),
                controller: _nomeController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding( //E-MAIL
              padding: EdgeInsets.only(top:10, left:30, right:30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width:0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical:5.0, horizontal:20.0),
                  filled: true, //preenchivel
                  fillColor: Colors.white, //na cor branca
                  alignLabelWithHint: true, //alinha o que ta dentro
                  hintText: 'E-mail',
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            Padding( //SENHA
              padding: EdgeInsets.only(top:10, left:30, right:30),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width:0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical:5.0, horizontal:20.0),
                  filled: true, //preenchivel
                  fillColor: Colors.white, //na cor branca
                  alignLabelWithHint: true, //alinha o que ta dentro
                  hintText: 'Senha',
                ),
                controller: _senhaController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                _erroMsg,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:20, left:30, right:30),
              child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container( //CADASTRAR
                    width: 150,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white70)
                      ),
                      child: Text('CADASTRAR',
                        style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
                      ),
                      color: Colors.black54,
                      onPressed: () {
                        _validacao();
                      },
                    ),
                  ),
                  Container( //VOLTAR
                    width: 150,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white70)
                      ),
                      child: Text('VOLTAR',
                        style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}