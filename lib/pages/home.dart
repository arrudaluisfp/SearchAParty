import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/model/estabelecimento.dart';
import 'package:com/pages/novo_estabelecimento.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:com/pages/estabelecimento1.dart';
import 'package:com/pages/estabelecimento2.dart';
import 'package:com/pages/estabelecimento3.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Firestore db = Firestore.instance;
  String user;

  String _getUser() {
    FirebaseAuth.instance.currentUser().then((currentUser) => {
      if (currentUser != "") {
        user = currentUser.uid,
      }
    });
    print("USER:: "+user);
    return user;
  }

  _body() {
    return StreamBuilder(
      stream: db.collection("estabelecimentos").snapshots(),
      //stream: db.collection(_getUser()).document("pets").collection("pets").snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.done:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando Estabelecimentos..."),
                  CircularProgressIndicator()
                ],
              ),
            );
          case ConnectionState.active:
            QuerySnapshot querySnapshot = snapshot.data;

            if(snapshot.hasError){
              return Container(
                child: Text("Ocorreram erros ao carregar dados!"),
              );
            } else {
              print ("DADOS CARREGADOS: "+snapshot.data.toString());

              return Container(
                child: ListView.builder(
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (context, index){
                    //recupera os estabelecimentos
                    List<DocumentSnapshot> estabelecimentos = querySnapshot.documents.toList();
                    DocumentSnapshot dados = estabelecimentos[index];

                    Estabelecimento estabelecimento = Estabelecimento(dados["nome"], dados ["cidade"], dados["foto"], dados["descricao"], dados["telefone"], dados["endereco"], dados["categoria"]);

                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(estabelecimento.foto),
                            ),
                            title: Text(estabelecimento.nome,
                            ),
                            subtitle: Text(estabelecimento.categoria + ", " + estabelecimento.cidade
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              OutlineButton(
                                borderSide: BorderSide(color: Colors.white70),
                                onPressed: () {
                                  if(dados["id"] == "001") {
                                    Navigator.push(context,
                                    MaterialPageRoute(
                                    builder: (context) => Estabelecimento1()
                                    )
                                    );
                                  }
                                  if(dados["id"] == "002") {
                                    Navigator.push(context,
                                    MaterialPageRoute(
                                    builder: (context) => Estabelecimento2()
                                    )
                                    );
                                  }
                                  if(dados["id"] == "003") {
                                    Navigator.push(context,
                                    MaterialPageRoute(
                                    builder: (context) => Estabelecimento3()
                                    )
                                    );
                                    }
                                  },
                                child: Text(
                                  'VER MAIS INFORMAÇÕES',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    );
                  }
                ),
              );
            }
/*
        */
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

