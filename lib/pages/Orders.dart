import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/classes/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../classes/item.dart';
import '../global.dart' as global;
import '../classes/store.dart';

class Orders extends StatefulWidget {
  Orders({required this.store});

  Store store;

  @override
  State<Orders> createState() => _OrdersState(store: store);
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [];
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
          backgroundColor: const Color(0xFF256F46),
          actions: [
            IconButton(
                onPressed: () async {
                  // _load_orders(store);
                  await Future.delayed(const Duration(milliseconds: 500));
                  _load_orders(store);
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: !got_data
            ? const Center(
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
                      const Center(
                          child: Text(
                        "سفارشی ندارید  : (",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 25),
                      )),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xFF256F46),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () async {
                              await Future.delayed(const Duration(milliseconds: 500));
                              _load_orders(store);
                              // _load_orders(store);
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 50,
                            )),
                      )
                    ],
                  ));
  }

  Future<void> _load_orders(Store store) async {
    setState(() {
      got_data = false;
    });
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
            rate: 2.5,
            desc: "[not needed]",
            id: element["product_id"].toString(),
            name: element["product_name"],
            sotreid: store.id,
            price: element["price"]);
        item.count = element["count"];
        items.add(item);
      });
      setState(() {
        orders.clear();
        orders.add(Order(
            origin: const LatLng(0, 0),
            goal: const LatLng(0, 0),
            store_address: "[not needed]",
            description: element["description"],
            address: element["delivery_location"],
            order_id: element["order_id"],
            customer: element["customer_name"],
            total_price: element["total_price"],
            discount: element["discount_code"],
            discount_value: element["discount_value"],
            status: element["status"],
            fast: element["fast_delivery"],
            store_name: "[not needed]",
            items: items));
      });
    });
    got_data = true;
  }

  Widget card(context, Order order) {
    return GestureDetector(
      onTap: () {
        bottomsheed(context, order);
      },
      child: Container(
        decoration: const BoxDecoration(
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
                        global.toPersianNumbers(order.total_price) + " تومان",
                        style: const TextStyle(fontSize: 18),
                        textDirection: TextDirection.rtl,
                      ),
                      order.status != "WAITING"
                          ? Row(
                              children: [
                                IconButton(
                                    iconSize: 30,
                                    onPressed: () async {
                                      global.postRequest({
                                        "order_id": order.order_id,
                                        "status": "Rejected"
                                      }, "/accept_reject_order/");
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      // _load_orders(store);
                                      _load_orders(store);
                                    },
                                    icon: const ImageIcon(
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
                                    icon: const ImageIcon(
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
// committing
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            order.address,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const ImageIcon(
                            AssetImage("images/location.png"),
                            color: Color(0xFF97b9a7),
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                  order.fast
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/fast.png",
                                width: 40,
                              ),
                              const Text(
                                "تحویل فوری!",
                                textDirection: TextDirection.rtl,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 10),
                              )
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  order.status == "PENDING"
                      ? "در انتظار فروشنده"
                      : order.status == "PROCESSING"
                          ? "در دست فروشنده"
                          : order.status == "WAITING"
                              ? "در انتظار پیک"
                              : "در دست پیک",
                  style: const TextStyle(
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

  void bottomsheed(BuildContext context, Order order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (builder) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: StatefulBuilder(
                builder: (builder, StateSetter setState) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    bottomNavigationBar: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text(order.description),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  order.discount_value == null
                                      ? "۰ تومان"
                                      : global.toPersianNumbers(order.discount_value) + ' تومان',
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Expanded(child: Container()),
                                const Text(
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
                                  global.toPersianNumbers(order.total_price) + ' تومان',
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(fontSize: 25),
                                ),
                                Expanded(child: Container()),
                                const Text(
                                  "مبلغ نهایی",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100, right: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 60,
                                  onPressed: () async {
                                    global.postRequest({
                                      "order_id": order.order_id,
                                      "status": order.status == "PENDING"
                                          ? "Accepted"
                                          : "Processed"
                                    }, "/accept_reject_order/");
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    _load_orders(store);
                                    Navigator.pop(context);
                                  },
                                  icon: const ImageIcon(
                                    AssetImage("images/cross.png"),
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(child: Container()),
                                IconButton(
                                  iconSize: 60,
                                  onPressed: () async {
                                    global.postRequest({
                                      "order_id": order.order_id,
                                      "status": "Rejected"
                                    }, "/accept_reject_order/");
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    _load_orders(store);
                                    Navigator.pop(context);
                                  },
                                  icon: const ImageIcon(
                                    AssetImage("images/tick.png"),
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        controller: scrollController,
                        itemCount: order.items.length,
                        itemBuilder: (context, i) {
                          return sheetProduct(order.items[i]);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
  Widget sheetProduct(Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                global.toPersianNumbers(item.price) + "  تومان",
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                item.count.toString() + " ╳  ",
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Expanded(child: Container()),
          Text(
            item.name,
            style: const TextStyle(fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFEAF3EE),
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
