import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/pages/Chat.dart';
import 'package:blink/pages/LastCheck.dart';
import 'package:blink/pages/OrderHistory.dart';
import 'package:blink/pages/OrderStatus.dart';
import 'package:blink/pages/Payment.dart';
import 'package:blink/pages/StorePage.dart';
import 'package:latlong2/latlong.dart';

import '../classes/item.dart';
import '../classes/store.dart';
import 'package:blink/pages/Address.dart';
import 'package:blink/pages/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global.dart' as global;
import 'ProfileEdit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

var _currentIndex = 1;
var sum = 0.0;
bool fast = false;
List<Store> stores = [
  Store(
      id: "1", name: "baq gilas", longitude: 12554, latitude: 98455, image: ""),
  // Store(id: "1", name: "baq gilas", longitude: 12554, latitude: 98455),
  // Store(id: "1", name: "baq gilas", longitude: 12554, latitude: 98455),
  // Store(id: "1", name: "baq gilas", longitude: 12554, latitude: 98455),
  // Store(id: "1", name: "baq gilas", longitude: 12554, latitude: 98455)
];

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    _loadAddresses();
    if (global.addressIndex != null) loadStores();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return global.addressIndex == null
        ? Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.085,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Address()));
                  },
                  child: Text(
                    "  افزودن آدرس   ",
                    style: TextStyle(fontSize: 25, color: Color(0xFF256F46)),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white)),
                ),
              ),
            ),
            backgroundColor: Color(0xFF256F46),
            body: Center(
              child: Text(
                "لطفا یک آدرس انتخاب کنید",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ))
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  MediaQuery.of(context).size.height *
                      0.08), // here the desired height
              child: AppBar(
                elevation: 0,
                backgroundColor:
                    _currentIndex == 0 ? Color(0xFF256F46) : Colors.white,
                actions: _currentIndex == 1
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                size: 50,
                                color: Color(0xFF256F46),
                              )),
                        )
                      ]
                    : (_currentIndex == 2)
                        ? [
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    size: 50,
                                    color: Color(0xFF256F46),
                                  )),
                            )
                          ]
                        : [],
                leading: _currentIndex == 1
                    ? Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: IconButton(
                          icon: Icon(
                            Icons.location_on,
                            size: 50,
                            color: Color(0xFF256F46),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Address()));
                          },
                        ),
                      )
                    : null,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xFF256F46),
              unselectedIconTheme: IconThemeData(color: Colors.white, size: 40),
              selectedIconTheme:
                  IconThemeData(color: Color(0xFF256F46), size: 50),
              currentIndex: _currentIndex,
              onTap: (index) {
                global.card.forEach((element) {
                  sum += element.price;
                });
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
                        color: _currentIndex == 0
                            ? Colors.white
                            : Color(0xFF256F46),
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
                        color: _currentIndex == 1
                            ? Colors.white
                            : Color(0xFF256F46),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage('images/cart.png'),
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 0.5,
                        color: _currentIndex == 2
                            ? Colors.white
                            : Color(0xFF256F46),
                        thickness: 2.5,
                        indent: 37,
                        endIndent: 30,
                      )
                    ],
                  ),
                  label: '',
                ),
              ],
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
                                  onPressed: () => profileChange(),
                                  icon: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Color(0xFF1C5334),
                                    size: 35,
                                  )),
                              GestureDetector(
                                onTap: () => profileChange(),
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
                                    global.first_name ,
                                    style: TextStyle(
                                      fontFamily: 'shabnam',
                                      color: Color(0xFF1C5334),
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    "مشتری",
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
                                    ? ImageIcon(
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
                              //   child: ImageIcon(
                              //     AssetImage('images/account.png'),
                              //     color: Color(0xFF618771),
                              //     size: 80,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            bottomsheed_takhfif(context);
                            print("tapped");
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
                                "تخفیف‌ها",
                                style: TextStyle(
                                    fontFamily: 'shabnam', fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            print("tapped");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderHistory()));
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
                                "تاریخچه سفارش‌ها",
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
                                    builder: (context) => Login()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 20, left: 20, bottom: 40),
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
                                style: TextStyle(
                                    fontFamily: 'shabnam', fontSize: 20),
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
                : _currentIndex == 1
                    ? SingleChildScrollView(
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontFamily: 'shbanam', fontSize: 30),
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontFamily: 'shabnam', fontSize: 30),
                                      hintTextDirection: TextDirection.rtl,
                                      // contentPadding: EdgeInsets.all(-100),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: IconButton(
                                          iconSize: 35,
                                          icon: ImageIcon(
                                            AssetImage("images/options.png"),
                                            color: Color(0xFF506f5d),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      prefixIcon: IconButton(
                                        iconSize: 60,
                                        icon: ImageIcon(
                                          AssetImage(
                                            "images/search.png",
                                          ),
                                          color: Color(0xFF506f5d),
                                          // size: 500,
                                        ),
                                        onPressed: () {},
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF506f5d),
                                            width: 3.5),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF506f5d),
                                            width: 0.0),
                                      )),
                                ),
                              ),
                              // Expanded(child: Container()),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Container()),
                                      Container(
                                        // height: 120,
                                        width: 120,
                                        // color: Colors.red,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        // color: Colors.red,
                                        child: Column(
                                          children: [
                                            Image.asset("images/pizza.png",
                                                height: 120),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "غذا",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ],
                                        ),

                                        // height: 120,
                                        width: 120,
                                        // color: Colors.red,
                                        child: Column(
                                          children: [
                                            Image.asset("images/arayeshi.png",
                                                height: 120, fit: BoxFit.cover),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "آرایشی",
                                                style: TextStyle(fontSize: 25),
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        // height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset("images/digital.png",
                                                height: 120, fit: BoxFit.cover),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "دیجیتال",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Container()),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Center(
                                                child: Text(
                                              "...",
                                              style: TextStyle(fontSize: 40),
                                            )),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      6), // changes position of shadow
                                                ),
                                              ],
                                              // color: Colors  .red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(75)),
                                              border: Border.all(
                                                  color: Color(0xFF256F46),
                                                  width: 2.0)),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        // height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset("images/lebas.png",
                                                height: 120),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "لباس",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        // height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset("images/market.png",
                                                height: 120, fit: BoxFit.cover),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "مارکت",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFF6F4699)))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          "٪ تخفیف‌دار‌ها            ",
                                          style: TextStyle(fontSize: 25),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEAF3EE),
                                          // color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      child: Row(
                                        children: [
                                          prodcut(),
                                          prodcut(),
                                          prodcut(),
                                          prodcut(),
                                          prodcut()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFF6F4699)))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          "  فروشگاه‌ها            ",
                                          style: TextStyle(fontSize: 25),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 500,
                                child: ListView.builder(
                                    itemCount: stores.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StorePage(
                                                          store: stores[i])));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color(0xFF256f46),
                                                      width: 1.5))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "images/star.png"),
                                                          color:
                                                              Color(0xFF256F46),
                                                        ),
                                                      ),
                                                      Text(
                                                        "4.1/5",
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                  Expanded(child: Container()),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Text(
                                                          stores[i].name,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "  آدرس انتخاب شده"),
                                                          ImageIcon(
                                                            AssetImage(
                                                                "images/location.png"),
                                                            color: Color(
                                                                0xFF97b9a7),
                                                            size: 30,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          // color: Color(0xffEAF3EE),
                                                          boxShadow: [
                                                            const BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            const BoxShadow(
                                                              color: Color(
                                                                  0xffEAF3EE),
                                                              spreadRadius:
                                                                  -0.2,
                                                              blurRadius: 5.0,
                                                            ),
                                                          ],
                                                          // color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: stores[i].image ==
                                                              ""
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          15),
                                                              child: ImageIcon(
                                                                AssetImage(
                                                                    "images/shop.png"),
                                                                size: 50,
                                                              ))
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              // Same radius as the CircleAvatar
                                                              child:
                                                                  Image.memory(
                                                                width: 100,
                                                                height: 100,
                                                                Uint8List.fromList(
                                                                    base64Decode(
                                                                        stores[i]
                                                                            .image)),
                                                                fit: BoxFit
                                                                    .cover, // Adjust the fit as needed
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
                                    }),
                              ),
                              SizedBox(
                                height: 5,
                              )
                              // Expanded(child: Container())
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Scrollbar(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: global.card.length == 0
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                                child: Text(
                                              "سبد خرید خالی است",
                                              style: TextStyle(fontSize: 25),
                                            )))
                                        : ListView.builder(
                                            itemCount: global.card.length,
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Row(children: [
                                                  !global.currentCardPayement
                                                      ? IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (global.card[i]
                                                                      .count >
                                                                  0) {
                                                                sum -= global
                                                                    .card[i]
                                                                    .price;
                                                                global.card[i]
                                                                    .count -= 1;
                                                                if ( global.card[i]
                                                                    .count == 0)
                                                                  global.card.removeAt(i);
                                                              }
                                                            });
                                                          },
                                                          icon: ImageIcon(
                                                            AssetImage(
                                                                'images/remove.png'),
                                                            color: Color(
                                                                0xFF1C5334),
                                                            size: 25,
                                                          ))
                                                      : Expanded(
                                                          child: Container()),
                                                  Text(
                                                    global.card[i].count
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'shabnam',
                                                        color:
                                                            Color(0xFF1C5334),
                                                        fontSize: 20),
                                                    // textAlign: TextAlign.center,
                                                  ),
                                                  !global.currentCardPayement
                                                      ? IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              sum += global
                                                                  .card[i]
                                                                  .price;
                                                              global.card[i]
                                                                  .count += 1;
                                                            });
                                                          },
                                                          icon: ImageIcon(
                                                            AssetImage(
                                                                'images/plus.png'),
                                                            color: Color(
                                                                0xFF1C5334),
                                                            size: 25,
                                                          ))
                                                      : Expanded(
                                                          child: Container()),
                                                  Expanded(child: Container()),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        global.card[i].name,
                                                        style: TextStyle(
                                                          fontFamily: 'shabnam',
                                                          color:
                                                              Color(0xFF1C5334),
                                                          fontSize: 23,
                                                        ),
                                                      ),
                                                      Text(
                                                        global.card[i].price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'shabnam',
                                                            color: Color(
                                                                0xFF1C5334),
                                                            fontSize: 19),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(child: Container()),
                                                  global.card[i].image == ""?Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Image(
                                                        image: AssetImage(
                                                            'images/product.png'),
                                                        width: 60),
                                                  ) : ClipRRect(
                                                        child: Image.memory(
                                                    width: 80,
                                                    Uint8List.fromList(
                                                          base64Decode(global.card[i].image)),
                                                    fit: BoxFit.fitWidth, // Adjust the fit as needed
                                                  ),
                                                    borderRadius: BorderRadius.circular(20),
                                                      ),
                                                  Expanded(child: Container())
                                                ]),
                                              );
                                            },
                                          ),
                                  )),
                            ),
                            Expanded(child: Container()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "تحویل فوری؟ هزینه ارسال افزایش پیدا می‌کند.",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 15),
                                ),
                                Checkbox(
                                    focusColor: Color(0xFF256F46),
                                    activeColor: Color(0xFF256F46),
                                    value: fast,
                                    onChanged: (value) {
                                      setState(() {
                                        fast = value ?? false;
                                      });
                                    }),
                              ],
                            ),
                            Expanded(child: Container()),
                            Text(
                              global.s == null
                                  ? "سفارشی ندارید"
                                  : "سفارش از " + global.s!.name,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 30,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20.0),
                              child: Table(
                                border:
                                    TableBorder.all(color: Colors.transparent),
                                textDirection: TextDirection.rtl,
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Text(
                                          'مالیات',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        child: Text(
                                          'رایگان',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Text(
                                          'هزینه ارسال',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        child: Text(
                                          '۵۰ هزار تومان',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Text(
                                          'جمع کل',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        child: Text(
                                          (sum + 50000.0).toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Container(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (global.currentCardPayement) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    OrderStatus()));
                                      } else {
                                        var req = [];
                                        global.card.forEach((element) {
                                          req.add({
                                            "product_id": element.id,
                                            "quantity": element.count
                                          });
                                        });
                                        // req.addAll();
                                        var res =
                                            global.postRequest(req, "/cart/");
                                        Map<String, dynamic> data = await res;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LastCheck(
                                                    sum: data["total_price"]
                                                        .toString())));
                                      }
                                    },
                                    child: Text(
                                      global.currentCardPayement
                                          ? "پیگیری"
                                          : "تکمیل",
                                      style: TextStyle(
                                          fontFamily: 'shabnam',
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF256F46),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      shadowColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  width: 120,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _currentIndex = 1;
                                      });
                                      // Navigator.pop(context);
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                                    },
                                    child: Text(
                                      "ادامه خرید",
                                      style: TextStyle(
                                          fontFamily: 'shabnam',
                                          fontSize: 20,
                                          color: Color(0xFF256F46)),
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFFFFFF),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(
                                              color: Color(0xFF256F46))),
                                      shadowColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                      ));
  }

  void changeBottomIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  profileChange() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileEdit()));
  }

  Future<void> _loadAddresses() async {
    var res = global.getRequest("/locations/");
    List<Map<String, dynamic>> data = await res;
    data.forEach((element) {
      setState(() {
        global.addressIndex = global.addresses.length;
        global.addresses.add(addres_data(
            name: element["name"],
            latLng: LatLng(double.parse(element["latitude"]),
                double.parse(element["longitude"])),
            id: element["id"],
            desc: element["address"]));
      });
    });
  }

  loadStores() async {
    // print("TOKEN" + global.token)
    var res = global.postRequest(
        {"longitude": "35.7219", "latitude": "51.3347", "token": global.token},
        "/stores/");
    Map<String, dynamic> data = await res;

    data.forEach((storeId, storeData) {
      // Extract store details
      var id = storeId;
      var name = storeData['name'];
      var longitude = storeData['location']['longitude'];
      var latitude = storeData['location']['latitude'];

      // Extract item details
      List<Item> items = [];
      (storeData['products'] as Map<String, dynamic>)
          .forEach((String itemId, itemData) {
        var itemName = itemData['name'];
        var itemPrice = double.parse(itemData['price']);
        var item = Item(
            id: itemId,
            name: itemName,
            price: itemPrice,
            sotreid: storeId,
            image: "");
        items.add(item);
      });

      // Create Store object and add it to the list
      var store = Store(
          id: id,
          name: name,
          longitude: double.parse(longitude),
          latitude: double.parse(latitude),
          items: items,
          image: storeData["image"]);
      setState(() {
        stores.add(store);
      });
    });
  }

  sendcart() async {
    // print("TOKEN" + global.token)
    var res = global.postRequest({}, "/sendcart/");
    Map<String, dynamic> data = await res;
  }

  prodcut() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            global.profile_imge == ""
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: ImageIcon(
                      AssetImage("images/shop.png"),
                      size: 50,
                    ))
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Same radius as the CircleAvatar
                      child: Image.memory(
                        width: 100,
                        Uint8List.fromList(base64Decode(global.profile_imge)),
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void bottomsheed_takhfif(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          "کدهای تخفیف",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFEAF3EE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 12),
                                blurRadius: 10,
                                spreadRadius: -5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    "تخفیف دسته ۱",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: ImageIcon(
                                        AssetImage("images/copy.png"),
                                        color: Color(0xFF2E8B57),
                                      ),
                                      iconSize: 35),
                                  Expanded(child: Container()),
                                  Text(
                                    "مقدار تخفیف",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "انقضاء تا n روز دیگر",
                                textDirection: TextDirection.rtl,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFEAF3EE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 12),
                                blurRadius: 10,
                                spreadRadius: -5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    "تخفیف دسته ۱",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: ImageIcon(
                                        AssetImage("images/copy.png"),
                                        color: Color(0xFF2E8B57),
                                      ),
                                      iconSize: 35),
                                  Expanded(child: Container()),
                                  Text(
                                    "مقدار تخفیف",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "انقضاء تا n روز دیگر",
                                textDirection: TextDirection.rtl,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFEAF3EE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 12),
                                blurRadius: 10,
                                spreadRadius: -5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    "تخفیف دسته ۱",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: ImageIcon(
                                        AssetImage("images/copy.png"),
                                        color: Color(0xFF2E8B57),
                                      ),
                                      iconSize: 35),
                                  Expanded(child: Container()),
                                  Text(
                                    "مقدار تخفیف",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "انقضاء تا n روز دیگر",
                                textDirection: TextDirection.rtl,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
