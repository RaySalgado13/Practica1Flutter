import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practica_flutter/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;  // new
import 'package:practica_flutter/comanda.dart';
import 'package:practica_flutter/components/PizzaImage.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;
  final List<String> orden = [];

  @override
  Widget build(BuildContext context) {
    if (loggedIn) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Pizzeria Mobile',
                style: Theme.of(context).textTheme.headlineLarge)),
        floatingActionButton: addComanda(orden: orden),
        body: Column(children: [
          Row(children: [
            Center(
                child: Text('Menu',
                    style: Theme.of(context).textTheme.headlineLarge))
          ]),
          // 3 pizzas
          Row(children: [PizzaImage(pizza: 'pizza1.png', onTap: () {
            print("Agregando pizza 1");
            orden.add("Pizza Italiana");
          })]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text('Italiana',
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text('Rica pizza Italiana',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])))
          ]),
          // 3 pizzas
          Row(children: [PizzaImage(pizza: 'pizza2.png', onTap: () {
            print("Agregando pizza 2");
            orden.add("Pizza 4 Quesos");
          })]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text('4 Quesos',
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text('Rica pizza de 4 quesos',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])))
          ]),
          // 3 pizzas
          Row(children: [PizzaImage(pizza: 'pizza3.png', onTap: () {
            print("Agregando pizza 3");
            orden.add("Pizza Pepperoni");
          })]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text('Pepperoni',
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text('La clásica pizza de pepperoni',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])))
          ]),
        ]),
      );
    } else {
      return const Authentication();
    }
  }
}

class PizzaImage extends StatefulWidget {
  final String pizza;
  final Function() onTap;

  const PizzaImage({Key? key, required this.pizza, required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PizzaImageState();
}

class _PizzaImageState extends State<PizzaImage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
            onTap: widget.onTap,
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Image.asset('assets/images/${widget.pizza}',
                        width: 100, height: 100),
                  ]))
            ])));
  }
}

class _addComandaState extends State<addComanda> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: FloatingActionButton(
          onPressed: () {
            print("Guardando la orden...");
            print(widget.orden);
            context.go('/cart', extra: {'orden': widget.orden});
            // CollectionReference ordendb =
            //     FirebaseFirestore.instance.collection('comanda');
            // final now = DateTime.now();
            // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
            // ordendb
            //     .add({
            //       'user': firebaseAuth.currentUser?.email,
            //       'diahora': now,
            //       'orden': {'descripcion': widget.orden.toList()}
            //     })
            //     .then((value) => {print("Comanda agregada")})
            //     .catchError((e) => print(e));
          },
          child: const Icon(Icons.shopping_cart),
        ));
  }
}

class addComanda extends StatefulWidget {
  addComanda({Key? key, required this.orden}) : super(key: key);
  List<String> orden;

  @override
  State<addComanda> createState() => _addComandaState();
}

