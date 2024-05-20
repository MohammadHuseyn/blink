import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/pages/OrderHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blink/global.dart' as global;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../classes/store.dart';
import 'Chat.dart';
import 'Home.dart';
import 'Login.dart';
import 'Orders.dart';
import 'ProfileEdit.dart';

class DeliveryHomePage extends StatefulWidget {
  // Store store;

  @override
  State<DeliveryHomePage> createState() => _DeliveryHomePageState();
}

var _currentIndex = 1;
late Store store;
var name = TextEditingController();
var price = TextEditingController();
var count = TextEditingController();
var desc = TextEditingController();
LatLng? latlngLocal = null;
List<Marker> markers = [];
var mapc = MapController();

class _DeliveryHomePageState extends State<DeliveryHomePage> {
  // _StoreHomePageState({required this.store});
  //

  @override
  void initState() {
    // TODO: implement initState
    // load_store();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = stores[0];
    // load_store();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF256F46),
          unselectedIconTheme: IconThemeData(color: Colors.white, size: 40),
          selectedIconTheme: IconThemeData(color: Color(0xFF256F46), size: 50),
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
                  ImageIcon(
                    AssetImage('images/user2.png'),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 0 ? Colors.white : Color(0xFF256F46),
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
                  ImageIcon(
                    AssetImage('images/home.png'),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 1 ? Colors.white : Color(0xFF256F46),
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
        appBar: _currentIndex == 1? AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.location_on,
              color: Color(0xFF2E8B57),
              size: 40,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("images/notification.png"),
                    color: Color(0xFF2E8B57),
                    size: 50,
                  )),
            )
          ],
        ) : AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: _currentIndex == 0
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
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Color(0xFF1C5334),
                                size: 35,
                              )),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileEdit()))
                            },
                            child: Text(
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
                                global.first_name + " " + global.last_name,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  color: Color(0xFF1C5334),
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "پیک",
                                style: TextStyle(
                                    fontFamily: 'shabnam',
                                    color: Colors.grey,
                                    fontSize: 19),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: global.profile_imge == ""
                                ? ImageIcon(
                                    AssetImage('images/account.png'),
                                    color: Color(0xFF618771),
                                    size: 80,
                                  )
                                : Image.memory(
                                    width: 150,
                                    Uint8List.fromList(
                                        base64Decode(global.profile_imge)),
                                    fit: BoxFit
                                        .cover, // Adjust the fit as needed
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Orders()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        padding: EdgeInsets.symmetric(vertical: 40),

                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.grey),
                        )),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "سفارش‌ها",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
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
                                builder: (context) => ChatPage()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        padding: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.grey),
                        )),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "ارتباط با پشتیبانی",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("logged out");
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(right: 20, left: 20, bottom: 40),
                        padding: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.grey),
                          bottom: BorderSide(color: Colors.grey),
                        )),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "خروج",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(child: Container())
                    ImageIcon(
                      AssetImage('images/logo.png'),
                      size: 80,
                      color: Color(0xFF399160),
                    ),
                    Text("with blink",
                        style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                            color: Color(0xFF1C5334))),
                    Text(
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
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFF899E92)))),
                            child: Padding(
                              padding: const EdgeInsets.only(
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            order(context),
                            order(context),
                            order(context),
                            order(context),
                            order(context),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0,0),
                            spreadRadius: 2,
                            blurRadius: 4
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //         bottom:
                            //         BorderSide(color: Color(0xFF899E92)))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0, bottom: 20, left: 30, top: 15),
                              child: Text(
                                "سفارشات روی نقشه",
                                style: TextStyle(
                                    fontSize: 25, color: Color(0xFF354E40)),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.6,
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

  order(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          bottomsheed(context);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF899E92), width: 2.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "۱۲۰۰۰۰ تومان",
                      style: TextStyle(fontSize: 20),
                      textDirection: TextDirection.rtl,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            AssetImage("images/cross.png"),
                            color: Colors.red,
                          ),
                          iconSize: 40,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            AssetImage("images/tick.png"),
                            color: Colors.green,
                          ),
                          iconSize: 40,
                        ),
                      ],
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
                        "نام فروشگاه",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text("آدرس مبدا "),
                          ImageIcon(
                            AssetImage("images/location.png"),
                            color: Color(0xFF97b9a7),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text("آدرس مقصد "),
                          ImageIcon(
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
                    decoration: BoxDecoration(
                        // color: Color(0xffEAF3EE),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                          ),
                          const BoxShadow(
                            color: Color(0xffEAF3EE),
                            spreadRadius: -0.2,
                            blurRadius: 5.0,
                          ),
                        ],
                        // color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: ImageIcon(
                        AssetImage("images/shop.png"),
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
              onTap: (tap_position, latlng) {
                latlngLocal = latlng;
                // print('Tapped at: $latlng');
                // Clear existing markers
                setState(() {
                  setState(() {
                    markers.clear();
                    markers.add(
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: latlng,
                        // Child parameter instead of builder
                        // Directly using an Icon as the child
                        child: Container(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ),
                    );
                  });
                  // Add a marker for the tapped location
                });
              },
              initialCenter: LatLng(35.715298, 51.404343),
              initialZoom: 5,
              interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.pinchZoom)),
          children: [
            tilelayer,
            MarkerLayer(markers: markers)
          ]),
    );
  }
  void bottomsheed(context) {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        // isScrollControlled: true,
        builder: (builder){
          return Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 7,
                    offset: Offset(0,0),
                    color: Colors.grey
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("images/cross.png"),
                        color: Colors.red,
                      ),
                      iconSize: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("images/tick.png"),
                        color: Colors.green,
                      ),
                      iconSize: 60,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              // height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)
                  )
              ),
              child: StatefulBuilder(builder: (BuildContext context,
                  StateSetter setState /*You can rename this!*/) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Text("موقعیت سفارش", style: TextStyle(fontSize: 25),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Text("نام فروشگاه",style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.asset("images/store.png", width: 50,),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Text("نام مشتری",style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.asset("images/customer.png", width: 50,),
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
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}

TileLayer get tilelayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.blink.example',
);


