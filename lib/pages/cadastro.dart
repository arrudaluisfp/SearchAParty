import 'package:flutter/material.dart';
import 'package:com/pages/home.dart';

    class Cadastro extends StatelessWidget {
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
                    keyboardType: TextInputType.text,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top:20, left:30, right:30),
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container( //ENTRAR
                        width: 150,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white70)
                          ),
                          child: Text('ENTRAR',
                            style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
                          ),
                          color: Colors.black54,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (Route<dynamic> route) => false,
                            );
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
