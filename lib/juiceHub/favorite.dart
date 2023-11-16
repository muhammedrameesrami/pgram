import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: width,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "Favorite page ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 500,
                            width: width,
                            child: ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: height * 0.2,
                                        width: width,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              height: height * 0.2,
                                              width: width * 0.41,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                image: DecorationImage(
                                                    fit: BoxFit.scaleDown,
                                                    image: AssetImage(
                                                        "assets/images/redbull.png")),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Transform.rotate(
                                                  angle: -45,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    child: Text("Add cart"),
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Transform.rotate(
                                              angle: 45,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {});
                                                },
                                                child: Text("Remove "),
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ]),
            )));
  }
}
