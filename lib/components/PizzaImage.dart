import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PizzaImage extends StatefulWidget {
  PizzaImage({Key? key, required this.image, required this.item, required this.orden}) : super(key: key);
  final String image;
  final String item;
  List<String> orden;

  @override
  State<PizzaImage> createState() => _PizzaImageState();
}

class _PizzaImageState extends State<PizzaImage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          final snackBar = SnackBar(
            content: Text("Se ha agregado a la orden: "+ widget.item),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          widget.orden.add(widget.item);
          print("\norden: \n");
          print(widget.orden);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Image.asset(widget.image, width: 200, height: 200, )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
