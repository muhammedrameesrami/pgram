import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/juiceHub/smoothi.dart';
import 'package:ui/juiceHub/data.dart';

import 'data.dart';

class coffee extends StatefulWidget {
  List coffeeitems;
  coffee({Key? key, required this.coffeeitems}) : super(key: key);

  @override
  State<coffee> createState() => _coffeeState();
}

class _coffeeState extends State<coffee> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
        width: 256,
        child: GridView.builder(
          itemCount: widget.coffeeitems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 30, crossAxisCount: 1),
          itemBuilder: (context, index) {
            final coffeeitem = widget.coffeeitems[index];

            return Container(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 17, right: 17, top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Shake(
                                      image: coffeeitem.image,
                                      name: coffeeitem.name,
                                      price: coffeeitem.price,
                                      index: index,
                                    )));
                      },
                      child: Container(
                        width: 250,
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.elliptical(290, 200),
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: coffeeitem.color,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 155, bottom: 150),
                                child: InkWell(
                                  onDoubleTap: () {
                                    setState(() {
                                      coffeeitem.fav = !coffeeitem.fav;
                                    });
                                  },
                                  child: Icon(
                                    (coffeeitem.fav == false)
                                        ? Icons.favorite_border_rounded
                                        : Icons.favorite,
                                    color: Colors.black26,
                                    size: 30,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    top: 1,
                    left: 5,
                    right: 55,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(coffeeitem.image)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 30, bottom: 5),
                          child: Text(
                            coffeeitem.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
