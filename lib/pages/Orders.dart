import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'StorePage.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF256F46),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              card(context),
              card(context),
              card(context),
            ],
          ),
        ));
  }
}

Widget card(context) {
  return GestureDetector(
    onTap: () {
      bottomsheed(context);
    },
    child: Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFF899E92), width: 2.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "۱۲۰۰۰ تومان",
                  style: TextStyle(fontSize: 18),
                  textDirection: TextDirection.rtl,
                ),
                Row(
                  children: [
                    IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("images/cross.png"),
                          color: Colors.red,
                        )),
                    IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("images/tick.png"),
                          color: Colors.green,
                        ))
                  ],
                )
              ],
            ),
            Expanded(child: Container()),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "نام خریدار",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "آدرس مقصد ",
                      style: TextStyle(fontSize: 15),
                    ),
                    ImageIcon(
                      AssetImage("images/location.png"),
                      color: Color(0xFF97b9a7),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Image.asset(
                    "images/fast.png",
                    width: 40,
                  ),
                  Text(
                    "تحویل فوری!",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

void bottomsheed(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: StatefulBuilder(builder: (builder, StateSetter setState) {
            return Scaffold(
                backgroundColor: Colors.transparent,
                bottomNavigationBar: Container(
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "۱۲۰۰۰ تومان",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            Text("تخفیف",style: TextStyle(
                              fontSize: 20,
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "۱۲۰۰۰ تومان",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 25),
                            ),
                            Expanded(child: Container()),
                            Text("مبلغ نهایی",style: TextStyle(
                              fontSize: 25,
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 60,
                                onPressed: () {},
                                icon: ImageIcon(
                                  AssetImage("images/cross.png"),
                                  color: Colors.red,
                                )),
                            Expanded(child: Container()),
                            IconButton(
                                iconSize: 60,
                                onPressed: () {},
                                icon: ImageIcon(
                                  AssetImage("images/tick.png"),
                                  color: Colors.green,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        sheetProduct(),
                        sheetProduct(),
                        sheetProduct(),
                      ],
                    ),
                  ),
                ));
          }),
        );
      });
}

Widget sheetProduct() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Text(
          "۱۲۰۰۰ تومان",
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 15),
        ),
        Expanded(child: Container()),
        Text(
          "نام محصول",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFEAF3EE),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  "images/product.png",
                  width: 40,
                ),
              )),
        )
      ],
    ),
  );
}
