import 'package:blink/pages/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../global.dart' as global;
import '../classes/store.dart';

class StorePage extends StatefulWidget {
  StorePage({required this.store});

  Store store;

  @override
  State<StorePage> createState() => _StorePageState(store: store);
}

class _StorePageState extends State<StorePage> {
  Store store;

  _StorePageState({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEAF3EE),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Container(
              color: Color(0xFFEAF3EE),
              // color: Colors.red,
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ImageIcon(
                  AssetImage("images/shop.png"),
                  size: 250,
                  color: Color(0xFF949494),
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          size: 32,
                          color: Color(0xFF256f46),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "4.1/5",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "نام فروشگاه",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_rounded),
                          Text(
                            "مشاهده نظرات",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 18),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "  آدرس انتخاب شده",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 18),
                          ),
                          ImageIcon(
                            AssetImage("images/location.png"),
                            color: Color(0xFF97b9a7),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: 35,
                              color: Color(0xFF2E8B57),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xFF2E8B57), width: 2.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xFF2E8B57), width: 2.0))),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.535853,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: store.items.length,
                          itemBuilder: (cntx, i) {
                            return Row(children: [
                              prodcut(15, 0, store.items[i]),
                              i + 1 >= store.items.length? Container() : prodcut(15, 0, store.items[i + 1]),
                            ],);
                          }),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 5)
                  ]
                  // border: Border.all(color: Colors.black)
                  ),
            ),
          ),
        ));
    // return Scaffold(
    //   body: ListView.builder(
    //       itemCount: store.items.length,
    //       itemBuilder: (context, i){
    //     return ListTile(
    //       title: Text(store.items[i].name),
    //       onTap: () {
    //         if (!global.currentCardPayement) {
    //           if (global.s == null)
    //             global.s = store;
    //           else if (global.s!.id != store.id) {
    //             global.card.removeRange(0, global.card.length - 1);
    //             global.s = store;
    //           }
    //           global.card.add(store.items[i]);
    //         }
    //       },
    //     );
    //   }),
    // );
  }

  prodcut(double left, double right, Item item) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: 20),
      child: GestureDetector(
        onTap: () {
          bottomShett();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.39,
          // width: 140,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 11), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: ImageIcon(
                  AssetImage("images/product.png"),
                  color: Color(0xFF517360),
                  size: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: global.card.contains(item)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    item.count -= 1;
                                  });
                                  if (item.count == 0) {
                                    _remove_from_cart(item);
                                  }
                                },
                                icon: ImageIcon(
                                    AssetImage(
                                      "images/remove.png",
                                    ),
                                    color: Colors.red
                                    // color: Colors.black,
                                    )),
                            Expanded(child: Container()),
                            Text(
                              item.count.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    item.count += 1;
                                  });
                                },
                                icon: ImageIcon(
                                  AssetImage("images/plus.png"),
                                  color: Color(0xFF2E8B57),
                                ))
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () {
                              item.count += 1;
                              _add_to_cart(item);
                            },
                            icon: ImageIcon(AssetImage("images/plus.png"),
                                color: Color(0xFF2E8B57))),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(item.name, style: TextStyle(fontSize: 23),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "120000",
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                      Text(
                        "120000",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Text(
                    "15%",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                  Expanded(child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _add_to_cart(Item item) {
    setState(() {
      global.card.add(item);
    });
  }

  void _remove_from_cart(Item item) {
    setState(() {
      global.card.remove(item);
    });
  }

  void bottomShett() {

  }
}
