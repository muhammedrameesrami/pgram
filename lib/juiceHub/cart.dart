import 'package:flutter/material.dart';
import 'package:ui/juiceHub/smoothi.dart';

import 'cartliist.dart';
import '../homepage.dart';

double total = 0;

class cart extends StatefulWidget {
  final inx;
  const cart({Key? key, required this.inx}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  var add = 1;
  var cash = 15;
  var tot = 0;
  @override
  void initState() {
    // Total();
    print(emty);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.backspace_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Ordered Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: emty.length,
                    itemBuilder: (context, index) {
                      index;

                      tot = tot +
                          (int.tryParse(emty[index]['cash'].toString()) ?? 0) *
                              add;

                      return cartlist(
                        data: emty[index],
                      );
                    }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.elliptical(400, 150))),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total :",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            total.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Text("Submit".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.grey)))),
                          onPressed: () {
                            setState(() {
                              final snackbar = SnackBar(
                                content: Text(
                                    "Your order placed please wait there thank you "),
                                duration: Duration(seconds: 6),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return HomePage();
                              }));
                            });
                          },
                        ),
                        TextButton(
                            child: Text("Cancel".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.grey)))),
                            onPressed: () {
                              setState(() {
                                emty.clear();
                              });
                            })
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

Total() {
  total = 0;
  for (var i = 0; i < emty.length; i++) {
    total += (emty[i]['cash'] * emty[i]['quantity']);
    print(emty[i]['price']);
  }

  print(total);
}
