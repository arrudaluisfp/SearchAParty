import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/model/estabelecimento.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Firestore db = Firestore.instance;

  _body() {
    return StreamBuilder(
      stream: db.collection("estabelecimentos").snapshots(),
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

                    Estabelecimento estabelecimento = Estabelecimento(dados["nome"], dados ["cidade"], dados["foto"]);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(estabelecimento.foto),
                      ),
                      title: Text(estabelecimento.nome,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(estabelecimento.cidade,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                ),
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


      bottomNavigationBar: BottomAppBar(
        color: Colors.black54.withOpacity(0.3),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.home), onPressed: null, color: Colors.white70),
              IconButton(icon: Icon(Icons.favorite), onPressed: null, color: Colors.white70),
              IconButton(icon: Icon(Icons.audiotrack), onPressed: null, color: Colors.white70),
              IconButton(icon: Icon(Icons.today), onPressed: null, color: Colors.white70),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: null,
          backgroundColor: Colors.white.withOpacity(0.3)
      ),
    );
  }

}

