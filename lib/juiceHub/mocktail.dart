import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/juiceHub/data.dart';
import 'package:ui/juiceHub/smoothi.dart';

class mocktail extends StatefulWidget {
  List<MocktailItems> mocktailItems;
  mocktail({Key? key, required this.mocktailItems}) : super(key: key);

  @override
  State<mocktail> createState() => _mocktailState();
}

class _mocktailState extends State<mocktail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
        width: 256,
        child: GridView.builder(
          itemCount: widget.mocktailItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 30, crossAxisCount: 1),
          itemBuilder: (context, index) {
            final cocktailItem = widget.mocktailItems[index];

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
                                      image: cocktailItem.image,
                                      name: cocktailItem.name,
                                      price: cocktailItem.price,
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
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.elliptical(130, 110),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(70)),
                              color: cocktailItem.color,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 155, bottom: 150),
                                child: InkWell(
                                  onDoubleTap: () {
                                    setState(() {
                                      cocktailItem.fav = !cocktailItem.fav;
                                    });
                                  },
                                  child: Icon(
                                    (cocktailItem.fav == false)
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
                              image: AssetImage(cocktailItem.image)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 30, bottom: 5),
                          child: Text(
                            cocktailItem.name,
                            style: TextStyle(
                                color: Colors.black45,
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
