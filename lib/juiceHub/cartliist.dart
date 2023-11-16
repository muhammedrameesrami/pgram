import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/juiceHub/coffee.dart';

class cartlist extends StatefulWidget {
  const cartlist({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  State<cartlist> createState() => _cartlistState();
}

class _cartlistState extends State<cartlist> {
  var add = 1;
  //var cash =15;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.brown.shade700,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: AssetImage(widget.data['image'])),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 100.0,
                      child: Text(
                        widget.data['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              add++;
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.add,
                            color: Colors.blue,
                            size: 15.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          add.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (add >= 1) {
                                add--;
                              }
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.minus,
                            color: Colors.black,
                            size: 9.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        (widget.data["price"] * add).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
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
