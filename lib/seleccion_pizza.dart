import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_flutter/authentication.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';

class Seleccion extends StatelessWidget {
  const Seleccion({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });
  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Selecciona tu Pizza',
                style: const TextStyle(fontSize: 50, fontFamily: 'Roboto')),
            Row(
              children: [
                Image.asset("assets/Hawaiiana.jpg"),
                Text('Hawaiana'),
                Text('Ingredientes: Jamón y piña')
              ],
            ),
            Row(
              children: [
                Image.asset("assets/pepperoni.jpg"),
                Text('Don Pepe'),
                Text('Ingredientes: Pepperoni y Champiñones')
              ],
            ),
            Row(
              children: [
                Image.asset("assets/cuatroQuesos.jpg"),
                Text('4 Quesos'),
                Text('Ingredientes: Mozarela, Gorgonzola, Fontina y Parmesano')
              ],
            ),
            Row(
              children: [
                TextButton(onPressed: (){}, child: Text("Ordenar"),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
