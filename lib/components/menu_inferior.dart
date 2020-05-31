import 'package:flutter/material.dart';

class MenuInferior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}
