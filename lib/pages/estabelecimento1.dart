import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Estabelecimento1 extends StatefulWidget {
  @override
  _Estabelecimento1State createState() => _Estabelecimento1State();
}

class _Estabelecimento1State extends State<Estabelecimento1> {

  Firestore db = Firestore.instance;

  _body() {
    return StreamBuilder(
        stream: db.collection("estabelecimentos").document("001").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.done:
            case ConnectionState.waiting:
              return Center(
                child: Row(
                  children: <Widget>[
                    Text("Carregando Estabelecimentos..."),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
              DocumentSnapshot querySnapshot = snapshot.data;

              if(snapshot.hasError){
                return Container(
                  child: Text("Ocorreram erros ao carregar dados!"),
                );
              } else {
                print ("DADOS CARREGADOS: "+snapshot.data.toString());

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top:10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white70,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image(
                        image: NetworkImage(querySnapshot["foto"]),
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top:8),
                      decoration: BoxDecoration(
                        color: Colors.white70.withOpacity(0.8),
                        border: Border.all(
                          color: Colors.black54,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          querySnapshot["categoria"],
                          style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 15),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top:10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white70.withOpacity(0.8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          querySnapshot["descricao"],
                          style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 24),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top:10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white70.withOpacity(0.8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          querySnapshot["social"],
                          style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white70.withOpacity(0.8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          querySnapshot["telefone"],
                          style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:30),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                          width: 5,
                        ),
                        color: Colors.white70.withOpacity(0.8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "AGENDA",
                          style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white70.withOpacity(0.8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Sem eventos prévios devido à pandemia, logo estaremos nos encotrando novamente!",
                          style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 15),
                        ),
                      ),
                    )
                  ],
                );
              }
          }
          return null;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage( //FUNDO
              image: AssetImage("assets/images/imagemFundo.png"),
              fit: BoxFit.cover,
            )
        ),
        child: _body(),
      ),

      appBar: AppBar(
        backgroundColor: Colors.black54.withOpacity(0.3),
        title: Center(
          child: Text('ESTABELECIMENTOS',
            style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
          ),
        ),
      ),
    );
  }
}