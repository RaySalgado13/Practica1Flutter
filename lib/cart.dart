import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider; // new
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_flutter/authentication.dart';
import 'app_state.dart';
import 'package:provider/provider.dart'; //nuevo

class Cart extends StatefulWidget {
  final List<String> orden;

  const Cart({Key? key, required this.orden}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var pizza1Total = 0;
    var pizza2Total = 0;
    var pizza3Total = 0;
    const pizza1Price = 25;
    const pizza2Price = 30;
    const pizza3Price = 20;
    for (var i = 0; i < widget.orden.length; i++) {
      if (widget.orden[i] == "Pizza Italiana") {
        pizza1Total++;
      } else if (widget.orden[i] == "Pizza 4 Quesos") {
        pizza2Total++;
      } else if (widget.orden[i] == "Pizza Pepperoni") {
        pizza3Total++;
      }
    }
    return Scaffold(
        appBar: AppBar(
            title: Text('Carrito',
                style: Theme.of(context).textTheme.headlineLarge)),
        body: Column(children: [
          //Row(children: const [PizzaImage(pizza: 'pizza1.png')]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text(
                          'Italiana: $pizza1Total, \$${pizza1Total * pizza1Price}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('Rica pizza Italiana',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])))
          ]),
          // 3 pizzas
         // Row(children: const [PizzaImage(pizza: 'pizza2.png')]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text(
                          '4 Quesos: $pizza2Total, \$${pizza2Total * pizza2Price}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('Rica pizza de 4 quesos',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])))
          ]),
          // 3 pizzas
         // Row(children: const [PizzaImage(pizza: 'pizza3.png')]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text(
                          'Pepperoni: $pizza3Total, \$${pizza3Total * pizza3Price}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('La clásica pizza de pepperoni',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])))
          ]),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text(
                          'Total: \$${pizza1Total * pizza1Price + pizza2Total * pizza2Price + pizza3Total * pizza3Price}',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ])))
          ]),
          addComanda(orden: widget.orden)
        ]));
  }
}

class PizzaImage extends StatefulWidget {
  final String pizza;

  const PizzaImage({Key? key, required this.pizza}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PizzaImageState();
}

class _PizzaImageState extends State<PizzaImage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
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
        child: TextButton(
          onPressed: () {
            print("Guardando la orden...");
            print(widget.orden);
            var pizza1Total = 0;
            var pizza2Total = 0;
            var pizza3Total = 0;
            const pizza1Price = 25;
            const pizza2Price = 30;
            const pizza3Price = 20;
            for (var i = 0; i < widget.orden.length; i++) {
              if (widget.orden[i] == "Pizza Italiana") {
                pizza1Total++;
              } else if (widget.orden[i] == "Pizza 4 Quesos") {
                pizza2Total++;
              } else if (widget.orden[i] == "Pizza Pepperoni") {
                pizza3Total++;
              }
            }
            final total = pizza1Total * pizza1Price +
                pizza2Total * pizza2Price +
                pizza3Total * pizza3Price;
            List<Map<String, Object>> subordenes = [];
            if (pizza1Total > 0) {
              subordenes.add({
                'descripcion': 'Pizza Italiana',
                'cantidad': pizza1Total,
                'subtotal': pizza1Total * pizza1Price
              });
            }
            if (pizza2Total > 0) {
              subordenes.add({
                'descripcion': 'Pizza 4 Quesos',
                'cantidad': pizza2Total,
                'subtotal': pizza2Total * pizza2Price
              });
            }
            if (pizza3Total > 0) {
              subordenes.add({
                'descripcion': 'Pizza Pepperoni',
                'cantidad': pizza3Total,
                'subtotal': pizza3Total * pizza3Price
              });
            }
            CollectionReference ordendb =
            FirebaseFirestore.instance.collection('comanda');
            final now = DateTime.now();
            final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
            ordendb.add({
              'user': firebaseAuth.currentUser?.email ?? '',
              'diahora': now,
              'total': total,
              'orden': [for (var i = 0; i < subordenes.length; i++) subordenes[i]]
            }).then((value) {
              print("Comanda agregada");
              context.go('/orden-confirmada');
            }).catchError((e) => print(e));
          },
          child: const Text('Confirmar Orden'),
        ));
  }
}

class addComanda extends StatefulWidget {
  addComanda({Key? key, required this.orden}) : super(key: key);
  List<String> orden;

  @override
  State<addComanda> createState() => _addComandaState();
}
