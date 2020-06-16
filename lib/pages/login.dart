import 'package:flutter/material.dart';
import 'package:com/pages/cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:com/pages/home.dart';
import 'package:com/model/Usuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  String _erroMsg = "";

  _validacao() {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (email.isNotEmpty || senha.isNotEmpty) {
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
        usuario.email = email;
        usuario.senha = senha;

        _entrar(usuario);
      }
    } else {
      setState(() {
        _erroMsg = "Preencha todos os campos";
      });
    }
  }

  _entrar(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser) {

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print("Erro retornado do Firebase: "+error.toString());
      setState(() {
        _erroMsg = "Erro ao tentar entrar!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage( //FUNDO
              image: AssetImage("assets/images/imagemFundo.png"),
              fit: BoxFit.cover,
            )
        ),

        child: Column(
          children: <Widget>[ //LOGO
            Padding(
              padding: EdgeInsets.only(top:90, left:30, right:30),
              child: Image.asset(
                "assets/images/logo.png",
                height: 170,
                width: 170,
              ),
            ),

            Expanded( //NOME DO APP
              child: Padding(
                padding: EdgeInsets.only(bottom:10),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Text(
                        "NOME DO APP",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                            fontFamily: 'Audiowide',
                            fontSize: 40,
                            color: Colors.grey
                        ),
                      )
                  ),
                ),
              ),
            ),

            Padding( //E-MAIL
              padding: EdgeInsets.only(top:90, left:30, right: 30),
              child:
              TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: new EdgeInsets.symmetric(vertical:5.0, horizontal:20.0),

                  filled: true,
                  fillColor: Colors.white,

                  alignLabelWithHint: true,
                  labelText: 'E-mail',
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            Padding( //SENHA
              padding: EdgeInsets.only(top:10, left:30, right: 30),
              child:
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: new EdgeInsets.symmetric(vertical:5.0, horizontal:20.0),

                  filled: true,
                  fillColor: Colors.white,

                  alignLabelWithHint: true,
                  labelText: 'Senha',
                ),
                controller: _senhaController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding( //BOTÕES
              padding: EdgeInsets.only(top:20, left: 30, right: 30, bottom:10),
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
                      child: Text('Cadastre-se',
                        style: TextStyle( fontFamily: 'Oswald', color: Colors.white
                        ),
                      ),
                      color: Colors.black54,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro()
                            )
                        );
                      },
                    ),
                  ),

                  Container( //ENTRAR
                    width: 150,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white70)
                      ),
                      child: Text('Entrar',
                        style: TextStyle(fontFamily: 'Oswald', color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        _validacao();
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 120),
              child: (
                  OutlineButton( //ESQUECI A SENHA
                    child: Text('Esqueci a senha',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          color: Colors.white70
                      ),
                    ),
                    onPressed: () {/** */},
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}