import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider; // new
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_flutter/authentication.dart';
import 'app_state.dart';
import 'package:provider/provider.dart'; //nuevo

class Despedida extends StatelessWidget {
  Despedida({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(' ',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Column(children: [
        Row(children: [
          Center(
              child: Text('Gracias por su compra',
                  style: Theme.of(context).textTheme.headlineSmall))
        ]),
        // 3 pizzas
      ]),
    );
  }
}
