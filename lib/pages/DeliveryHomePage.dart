import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blink/global.dart' as global;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../classes/order.dart';
import 'Chat.dart';
import 'Login.dart';

// import 'Orders.dart';
import 'ProfileEdit.dart';

class DeliveryHomePage extends StatefulWidget {
  // Store store;

  @override
  State<DeliveryHomePage> createState() => _DeliveryHomePageState();
}

var _currentIndex = 1;
var name = TextEditingController();
var price = TextEditingController();
var count = TextEditingController();
var desc = TextEditingController();
bool dispatching = false;
LatLng? latlngLocal = null;
List<Marker> markers = [];
List<Marker> two_markers = [];
bool two_markers_bool = false;
List<Order> orders = [];
List<Order> dispatching_order = [];
bool got_data = false;
var mapc = MapController();

class _DeliveryHomePageState extends State<DeliveryHomePage> {
  // _StoreHomePageState({required this.store});
  //

  @override
  void initState() {

    // TODO: implement initState
    _load_orders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // store = stores[0];
    // load_store();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF256F46),
          unselectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
          selectedIconTheme: const IconThemeData(color: Color(0xFF256F46), size: 50),
          currentIndex: _currentIndex,
          onTap: (index) {
            // global.card.forEach((element) {
            //   sum += element.price;
            // });
            changeBottomIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const ImageIcon(
                    AssetImage('images/user2.png'),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 0 ? Colors.white : const Color(0xFF256F46),
                    thickness: 2.5,
                    indent: 30,
                    endIndent: 30,
                  )
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const ImageIcon(
                    AssetImage('images/home.png'),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 1 ? Colors.white : const Color(0xFF256F46),
                    thickness: 2.5,
                    indent: 30,
                    endIndent: 30,
                  )
                ],
              ),
              label: '',
            ),
          ],
        ),
        appBar: _currentIndex == 1
            ? AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    _load_orders();
                    // _load_orders();
                  },
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Color(0xFF2E8B57),
                    size: 40,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage("images/notification.png"),
                          color: Color(0xFF2E8B57),
                          size: 50,
                        )),
                  )
                ],
              )
            : AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
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
            : _currentIndex == 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        // Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Color(0xFF1C5334),
                                    size: 35,
                                  )),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ProfileEdit()))
                                },
                                child: const Text(
                                  "ویرایش",
                                  style: TextStyle(
                                      fontFamily: 'shabnam',
                                      color: Color(0xFF1C5334),
                                      fontSize: 20),
                                ),
                              ),
                              Expanded(child: Container()),
                              Column(
                                children: [
                                  Text(
                                    global.first_name,
                                    style: const TextStyle(
                                      fontFamily: 'shabnam',
                                      color: Color(0xFF1C5334),
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "پیک",
                                    style: TextStyle(
                                        fontFamily: 'shabnam',
                                        color: Colors.grey,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                child: global.profile_imge == ""
                                    ? const ImageIcon(
                                        AssetImage('images/account.png'),
                                        color: Color(0xFF618771),
                                        size: 80,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(75),
                                        // Same radius as the CircleAvatar
                                        child: Image.memory(
                                          width: 100,
                                          Uint8List.fromList(base64Decode(
                                              global.profile_imge)),
                                          fit: BoxFit
                                              .cover, // Adjust the fit as needed
                                        ),
                                      ),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 17),
                              //   child:
                              // ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            print("tapped");
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => Orders(store: store,)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            padding: const EdgeInsets.symmetric(vertical: 40),

                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(color: Colors.grey),
                            )),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.03,
                            child: const Center(
                              child: Text(
                                "سفارش‌ها",
                                style: TextStyle(
                                    fontFamily: 'shabnam', fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            // print("tapped");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(isAdmin: false)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(color: Colors.grey),
                            )),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.03,
                            child: const Center(
                              child: Text(
                                "ارتباط با پشتیبانی",
                                style: TextStyle(
                                    fontFamily: 'shabnam', fontSize: 20),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            print("logged out");
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 40),
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(color: Colors.grey),
                              bottom: BorderSide(color: Colors.grey),
                            )),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.03,
                            child: const Center(
                              child: Text(
                                "خروج",
                                style: TextStyle(
                                    fontFamily: 'shabnam', fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(child: Container())
                        const ImageIcon(
                          AssetImage('images/logo.png'),
                          size: 80,
                          color: Color(0xFF399160),
                        ),
                        const Text("with blink",
                            style: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 20,
                                color: Color(0xFF1C5334))),
                        const Text(
                          "v 1.0.0",
                          style: TextStyle(
                              fontFamily: 'shabnam',
                              fontSize: 20,
                              color: Color(0xFF1C5334)),
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFF899E92)))),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      right: 15.0, bottom: 20, left: 30),
                                  child: Text(
                                    "سفارش‌های اطراف",
                                    style: TextStyle(
                                        fontSize: 25, color: Color(0xFF354E40)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) {
                                  return order(context, orders[i]);
                                })),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2,
                                    blurRadius: 4)
                              ]),
                          child: Column(
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border(
                                //         bottom:
                                //         BorderSide(color: Color(0xFF899E92)))),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      right: 15.0,
                                      bottom: 20,
                                      left: 30,
                                      top: 15),
                                  child: Text(
                                    "سفارشات روی نقشه",
                                    style: TextStyle(
                                        fontSize: 25, color: Color(0xFF354E40)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  child: map())
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
  }

  void changeBottomIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  order(BuildContext context, Order order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          bottomsheed(context, order);
        },
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF899E92), width: 2.0))),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          order.delivery_price.toString() + " تومان",
                          style: const TextStyle(fontSize: 15),
                          textDirection: TextDirection.rtl,
                        ),
                        IconButton(
                          onPressed: () async {
                            if ((order.status == "WAITING" && !dispatching) ||
                                (order.status == "DISPATCHED" && dispatching)) {
                              global.postRequest({
                                "order_id": order.order_id,
                                "status": order.status == "WAITING"
                                    ? "Accepted"
                                    : "Delivered"
                              }, "/delivery_orders/");
                              await Future.delayed(const Duration(milliseconds: 500));
                              _load_orders();
                              dispatching = !dispatching;
                            }
                          },
                          icon: const ImageIcon(
                            AssetImage("images/tick.png"),
                            color: Colors.green,
                          ),
                          iconSize: 40,
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "از " + order.store_name,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "برای " + order.customer.split(" ")[0],
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "از " + order.store_address,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const ImageIcon(
                                AssetImage("images/location.png"),
                                color: Color(0xFF97b9a7),
                                size: 30,
                              ),
// committing
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "به " + order.address,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const ImageIcon(
                                AssetImage("images/location.png"),
                                color: Color(0xFF97b9a7),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        decoration: const BoxDecoration(
                            // color: Color(0xffEAF3EE),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xffEAF3EE),
                                spreadRadius: -0.2,
                                blurRadius: 5.0,
                              ),
                            ],
                            // color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: global.profile_imge == ""
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: ImageIcon(
                                  AssetImage("images/shop.png"),
                                  size: 50,
                                ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                // Same radius as the CircleAvatar
                                child: Image.memory(
                                  width: 80,
                                  Uint8List.fromList(
                                      base64Decode(global.profile_imge)),
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  order.status == "WAITING"
                      ? "در دست فروشنده"
                      : order.status == "DISPATCHED"
                          ? "شما در حال تحویل این سفارش هستید"
                          : "UNKNOWN",
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget map() {
    return Scaffold(
      body: FlutterMap(
          mapController: mapc,
          options: MapOptions(
              onTap: (tapPosition, latlng) {},
              initialCenter: const LatLng(35.715298, 51.404343),
              initialZoom: 5,
              interactionOptions:
                  const InteractionOptions(flags: InteractiveFlag.all)),
          children: [
            tilelayer,
            MarkerLayer(markers: two_markers_bool ? two_markers : markers)
          ]),
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
            return  Container(
                decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            ),
            ),
            child: Scaffold(
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 7,
                    offset: Offset(0, 0),
                    color: Colors.grey,
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.085,
                    child: ElevatedButton(
                      onPressed: () async {
                        if ((order.status == "WAITING" && !dispatching) ||
                            (order.status == "DISPATCHED" && dispatching)) {
                          global.postRequest({
                            "order_id": order.order_id,
                            "status": order.status == "WAITING"
                                ? "Accepted"
                                : "Delivered"
                          }, "/delivery_orders/");
                          if (order.status == "DISPATCHED") {
                            setState(() {
                              dispatching = false;
                            });
                          } else if (order.status == "WAITING") {
                            setState(() {
                              dispatching = true;
                            });
                          }
                          await Future.delayed(const Duration(milliseconds: 500));
                          _load_orders();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        order.status == "WAITING"
                            ? "  قبول سفارش   "
                            : "  تحویل داده شد  ",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        backgroundColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFF256F46),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              body:StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  const Text(
                                    "موقعیت سفارش",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    order.store_name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      "images/store.png",
                                      width: 40,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    order.customer,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      "images/customer.png",
                                      width: 40,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: map(),
                              ),
                            ),
                            Divider(color:  Color(0xFF256F46)),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                order.description,
                                style: TextStyle(
                                  fontSize: 17
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ));
          },
        );
      },
    );
  }
  Future<void> _load_orders() async {
    setState(() {
      markers.clear();
      orders.clear();
      got_data = false;
    });
    var res = global.getRequest("/delivery_orders/");
    List<Map<String, dynamic>> data = await res;
    // List<Map<String, dynamic>> orders_data = List<Map<String, dynamic>>.from(data["order"]);

    setState(() {
      bool dis = false;
      List<Order> oO = [];
        data.forEach((element) {
          Order o = Order(
              goal: LatLng(
                  element["delivery_latitude"], element["delivery_longitude"]),
              origin:
              LatLng(element["store_latitude"], element["store_longitude"]),
              store_address: element["store_address"],
              address: element["delivery_address"],
              order_id: element["order_id"],
              customer: element["customer_name"],
              total_price: 0.0,
              discount: element["discount_code"],
              discount_value: 0.0,
              description: element["description"],
              status: element["status"],
              store_name: element["store_name"],
              fast: element["fast_delivery"],
              items: []);
          o.delivery_price = element["delivery_price"];
          if (o.status == "DISPATCHED")
            dis = true;
          oO.add(o);
        });
        oO.forEach((element) {
          if (!dis)
            orders.add(element);
          else if (element.status == "DISPATCHED") {
            orders.add(element);
            dispatching = true;
          }
        });
    });
    setState(() {
      markers.clear();
      orders.forEach((element) {
        // print("HERE!" + element.origin.latitude.toString() + " " + element.origin.longitude.toString());
        markers.add(Marker(
            point: element.origin,
            child: IconButton(
              icon: const Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
              onPressed: () {
                // print("here");
                two_markers.clear();
                setState(() {
                  two_markers.add(Marker(
                      point: element.origin,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            two_markers_bool = false;
                          });
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                      ),
                      alignment: Alignment.topCenter));
                  two_markers.add(Marker(
                      point: element.goal,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            bottomsheed(context, element);
                          });
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.orange,
                        ),
                      ),
                      alignment: Alignment.topCenter));
                  two_markers_bool = true;
                });
              },
              iconSize: 30,
            ),
            alignment: Alignment.topCenter));
      });
      ;
      got_data = true;
    });
  }
}

TileLayer get tilelayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.blink.example',
    );
