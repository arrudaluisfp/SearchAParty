import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class NovoEstabelecimento extends StatefulWidget {
  @override
  _NovoEstabelecimentoState createState() => _NovoEstabelecimentoState();
}

class _NovoEstabelecimentoState extends State<NovoEstabelecimento> {

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _generoController = TextEditingController();
  String _erroMsg = "";
  File _foto;

  Future _getImage() async {
    PickedFile img;
    ImagePicker cam = ImagePicker();
    img = await cam.getImage(source: ImageSource.camera);

    setState(() {
      _foto = File(img.path);
    });
  }

  _validacao() {
    String nome = _nomeController.text;
    String cidade = _cidadeController.text;
    String genero = _generoController.text;

    if(nome.isNotEmpty && cidade.isNotEmpty && genero.isNotEmpty) {
      _cadastrar();
    } else {
      setState(() {
        _erroMsg = "Preencha todos os campos!";
      });
    }
  }

  Future _cadastrar() async {
    String nome = _nomeController.text;
    String cidade = _cidadeController.text;
    String genero = _generoController.text;

    String newEstabelecimento;
    FirebaseUser user;

    await FirebaseAuth.instance.currentUser().then((currentUser) => {
      if (currentUser != null) {
        user = currentUser
      }
    });

    await Firestore.instance
      .collection(user.uid)
      .document("estabelecimentos")
      .collection("estabelecimentos")
      .add({
        "nome": nome,
        "cidade": cidade,
        "genero": genero,
      }).then((value) {
        newEstabelecimento = value.documentID;
      });

    print("ID DOC: "+newEstabelecimento);

    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference rootFolder = storage.ref();
    StorageReference arquivo = rootFolder.child("estabelecimentos_avatar").child(user.uid).child(newEstabelecimento);
    arquivo.putFile(_foto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: _image(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _avatar(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _addPhoto(),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: _backBtn(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _title(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _content(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _action(),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage( //FUNDO
            image: AssetImage("assets/images/imagemFundo.png"),
            fit: BoxFit.cover,
          )
      ),
    );
  }

  Widget _avatar() {
    return _foto == null
        ? Container()
        : Padding(
          padding: EdgeInsets.only(top: 225, left: 150, right: 30),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(_foto.path),
          ),
      ),
    );
  }

  Widget _addPhoto() {
    return Container(
      height: 60,
      width: 330,
      margin: EdgeInsets.only(
        left: 40,
        top: 100,
      ),
      child: RaisedButton(
        color: Colors.transparent,
        onPressed: () {
          _getImage();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Icon(
                Icons.camera_enhance,
                color: Colors.white70,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                "Clique para adicionar nova foto",
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white.withOpacity(0.5)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _action() {
    return Container( //ADICIONAR
      width: 200,
      height: 45,
      margin: EdgeInsets.only(bottom: 45),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white70)
        ),
        child: Text('ADICIONAR',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.white
          ),
        ),
        color: Colors.black54,
        onPressed: () {
          _validacao();
        },
      ),
    );
  }

  Widget _backBtn(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: EdgeInsets.only(left: 40, top: 100),
      child: RaisedButton(
        color: Colors.white70,
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _title() { //TITULO ACIMA DOS CAMPOS
    return Container(
        height: 405,
        width: 510,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Text(
          "Novo Estabelecimento",
          textAlign: TextAlign.center,

          style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 25,
              color: Colors.white70),
        )
    );
  }

  Widget _content() {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.grey, width: 0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  //preenchivel
                  fillColor: Colors.white70,
                  //na cor branca
                  alignLabelWithHint: true,
                  //alinha o que ta dentro
                  hintText: 'Nome',
                ),
                controller: _nomeController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.grey, width: 0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  //preenchivel
                  fillColor: Colors.white70,
                  //na cor branca
                  alignLabelWithHint: true,
                  //alinha o que ta dentro
                  hintText: 'Cidade',
                ),
                controller: _cidadeController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.grey, width: 0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  //preenchivel
                  fillColor: Colors.white70,
                  //na cor branca
                  alignLabelWithHint: true,
                  //alinha o que ta dentro
                  hintText: 'Gênero',
                ),
                controller: _generoController,
                keyboardType: TextInputType.text,
              ),
            ),
          ]
      ),
    );
  }
}