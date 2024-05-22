import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/classes/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/item.dart';
import '../global.dart' as global;
import '../classes/store.dart';
import 'Home.dart';
import 'StorePage.dart';

class Orders extends StatefulWidget {
  Orders({required this.store});

  Store store;

  @override
  State<Orders> createState() => _OrdersState(store: store);
}

class _OrdersState extends State<Orders> {
  List<order> orders = [];
  bool got_data = false;

  _OrdersState({required this.store});

  Store store;

  @override
  void initState() {
    _load_orders(store);
    _load_orders(store);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF256F46),
          actions: [
            IconButton(onPressed: () {_load_orders(store);_load_orders(store);}, icon: Icon(Icons.refresh))
          ],
        ),
        body: !got_data
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.lightGreen,
                      color: Color(0xFF256F46),
                      strokeWidth: 5,
                      strokeAlign: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "در حال دریافت سفارشات",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 30, color: Color(0xFF256F46)),
                    ),
                  ],
                ),
              )
            : !orders.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, i) {
                          return card(context, orders[i]);
                        }),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "سفارشی ندارید  : (",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 25),
                      )),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFF256F46),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () {
                              _load_orders(store);
                              _load_orders(store);
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 50,
                            )),
                      )
                    ],
                  ));
  }

  Future<void> _load_orders(Store store) async {
    var res = global.getRequest("/accept_reject_order/?store_id=" + store.id);
    List<Map<String, dynamic>> data = await res;
    // List<Map<String, dynamic>> orders_data = List<Map<String, dynamic>>.from(data["order"]);
    data.forEach((element) {
      List<Item> items = [];
      List<Map<String, dynamic>> order_items =
          List<Map<String, dynamic>>.from(element["order_items"]);

      order_items.forEach((element) {
        Item item = Item(
            image: element["image"],
            id: element["product_id"].toString(),
            name: element["product_name"],
            sotreid: store.id,
            price: element["price"]);
        item.count = element["count"];
        items.add(item);
      });
      setState(() {
        orders.clear();
        orders.add(order(
            address: element["delivery_location"],
            order_id: element["order_id"],
            customer: element["customer_name"],
            total_price: element["total_price"],
            discount: element["discount_code"],
            discount_value: element["discount_value"],
            status: element["status"],
            items: items));
      });
    });
    got_data = true;
  }

  Widget card(context, order order) {
    return GestureDetector(
      onTap: () {
        bottomsheed(context, order);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xFF899E92), width: 2.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        order.total_price.toString() + " تومان",
                        style: TextStyle(fontSize: 18),
                        textDirection: TextDirection.rtl,
                      ),
                      order.status != "DISPATCHED"
                          ? Row(
                              children: [
                                IconButton(
                                    iconSize: 30,
                                    onPressed: () {
                                      global.postRequest({
                                        "order_id": order.order_id,
                                        "status": "Rejected"
                                      }, "/accept_reject_order/");
                                      _load_orders(store);
                                      _load_orders(store);
                                    },
                                    icon: ImageIcon(
                                      AssetImage("images/cross.png"),
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    iconSize: 30,
                                    onPressed: () {
                                      global.postRequest({
                                        "order_id": order.order_id,
                                        "status": order.status == "PENDING"
                                            ? "Accepted"
                                            : "Processed"
                                      }, "/accept_reject_order/");
                                      _load_orders(store);
                                      _load_orders(store);
                                    },
                                    icon: ImageIcon(
                                      AssetImage("images/tick.png"),
                                      color: Colors.green,
                                    ))
                              ],
                            )
                          : Container()
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          order.customer,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            order.address,
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  order.status == "PENDING"
                      ? "در انتظار فروشنده"
                      : order.status == "PROCESSING"
                          ? "در دست فروشنده"
                          : "در دست پیک",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF256F46),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bottomsheed(context, order order) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: StatefulBuilder(builder: (builder, StateSetter setState) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar: Container(
                    height: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                order.discount_value == null
                                    ? "۰ تومان"
                                    : order.discount_value.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "تخفیف",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                order.total_price.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 25),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "مبلغ نهایی",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
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
                                  onPressed: () {
                                    global.postRequest({
                                      "order_id": order.order_id,
                                      "status": "Rejected"
                                    }, "/accept_reject_order/");
                                    _load_orders(store);
                                    _load_orders(store);
                                    Navigator.pop(context);
                                  },
                                  icon: ImageIcon(
                                    AssetImage("images/cross.png"),
                                    color: Colors.red,
                                  )),
                              Expanded(child: Container()),
                              IconButton(
                                  iconSize: 60,
                                  onPressed: () {
                                    global.postRequest({
                                      "order_id": order.order_id,
                                      "accept": true
                                    }, "/accept_reject_order/");
                                    _load_orders(store);
                                    _load_orders(store);
                                    Navigator.pop(context);
                                  },
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
                  body: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ListView.builder(
                        itemCount: order.items.length,
                        itemBuilder: (context, i) {
                          return sheetProduct(order.items[i]);
                        }),
                  ));
            }),
          );
        });
  }

  Widget sheetProduct(Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                item.price.toString() + "  تومان",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                item.count.toString() + " ╳  ",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Expanded(child: Container()),
          Text(
            item.name,
            style: TextStyle(fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFEAF3EE),
                    borderRadius: BorderRadius.circular(20)),
                child: item.image == ""
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          "images/product.png",
                          width: 40,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.memory(
                          width: 70,
                          Uint8List.fromList(base64Decode(item.image)),
                          fit: BoxFit.fitWidth, // Adjust the fit as needed
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
