import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class addComanda extends StatefulWidget {
  addComanda({Key? key, required this.orden}) : super(key: key);
  List<String> orden;

  @override
  State<addComanda> createState() => _addComandaState();
}

class _addComandaState extends State<addComanda> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
        onPressed: () {
          print("Guardando la orden..." + widget.orden.toString());
          CollectionReference ordendb = FirebaseFirestore.instance.collection('comanda');
          final now = DateTime.now();
          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          ordendb.add({
            'user' : firebaseAuth.currentUser?.email,
            'diahora' : now,
            'orden' : {
              'descripcion' : widget.orden.toList()
            },
          }).then((value) => print("Comanda Agregada")).catchError((error) => print("Fallo al agregar la comanda: $error"));

        },
        child: Text("Guardar su pedido") ,
      ),
    );
  }
}
