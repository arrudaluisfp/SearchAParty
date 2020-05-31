import 'package:flutter/material.dart';

class NovoEstabelecimento extends StatelessWidget {
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
              alignment: Alignment.bottomCenter,
              child: _content(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _action(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _backBtn(context),
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

  Widget _action() {
    return Container( //CADASTRAR
      width: 200,
      height: 45,
      margin: EdgeInsets.only(bottom:  45),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white70)
        ),
        child: Text('ADICIONAR',
          style: TextStyle( fontFamily: 'Oswald', color: Colors.white
          ),
        ),
        color: Colors.black54,
        onPressed: () {/* */},
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

  Widget _content() {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color:Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top:40, left:30, right:30),
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
                fillColor: Colors.white70, //na cor branca
                alignLabelWithHint: true, //alinha o que ta dentro
                hintText: 'Nome',
              ),
              keyboardType: TextInputType.text,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:20, left:30, right:30),
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
                fillColor: Colors.white70, //na cor branca
                alignLabelWithHint: true, //alinha o que ta dentro
                hintText: 'Cidade',
              ),
              keyboardType: TextInputType.text,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:20, left:30, right:30),
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
                fillColor: Colors.white70, //na cor branca
                alignLabelWithHint: true, //alinha o que ta dentro
                hintText: 'Foto (Link)',
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ]
      ),
    );
  }
}
