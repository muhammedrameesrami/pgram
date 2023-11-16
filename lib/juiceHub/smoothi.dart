import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/juiceHub/cart.dart';

List emty = [];

class Shake extends StatefulWidget {
  final image;
  final name;
  final price;
  final index;
  const Shake(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.index})
      : super(key: key);

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> {
  var counter = 1;

  var height;
  var width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.brown,
              child: Padding(
                padding: const EdgeInsets.only(top: 280),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 5, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.favorite_outline_sharp)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 20),
                          child: Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < 3 ? Icons.star : Icons.star_border,
                                    color: Colors.yellow[700],
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "4.5/5",
                                  style: TextStyle(color: Colors.white),
                                )),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            "${widget.price * counter}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: Row(
                            children: [
                              Container(
                                height: height * 0.05,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.brown,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      counter++;
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.plus,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                counter.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.brown,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (counter >= 1) {
                                        counter--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.minus,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Cold,creamy,thick mango",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "smoothie filled with",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "juicy mango",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              var count = 0;
                              setState(() {
                                if (emty.isEmpty) {
                                  emty.add({
                                    "image": widget.image,
                                    "name": widget.name,
                                    "price": widget.price,
                                  });
                                  count++;
                                } else {
                                  for (int i = 0; i < emty.length; i++) {
                                    if (widget.name == emty[i]['name']) {
                                      count++;
                                    }
                                  }
                                }
                                if (count == 0) {
                                  emty.add({
                                    "image": widget.image,
                                    "name": widget.name,
                                    "price": widget.price,
                                  });
                                }
                                ;
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => cart(
                                            inx: widget.index,
                                          )));
                            },
                            child: Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.brown,
                              ),
                              child: Center(
                                  child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 1,
              left: 1,
              child: Image(
                width: 400,
                height: 370,
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  widget.image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.05,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cart(
                                      inx: widget.index,
                                    )));
                      },
                      child: Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
