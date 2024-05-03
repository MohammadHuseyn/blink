import 'package:blink/pages/Address.dart';
import 'package:blink/pages/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProfileEdit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

var _currentIndex = 1;
var card = [];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
                      },
                    ),
                  )
                : null,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF256F46),
          unselectedIconTheme: IconThemeData(color: Colors.white, size: 40),
          selectedIconTheme: IconThemeData(color: Color(0xFF256F46), size: 50),
          currentIndex: _currentIndex,
          onTap: (index) {
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
                    color:
                        _currentIndex == 2 ? Colors.white : Color(0xFF256F46),
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
            ? Container(
                child: Column(
                  children: [
                    // Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () =>
                                profileChange(),
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Color(0xFF1C5334),
                                size: 35,
                              )),
                          GestureDetector(
                            onTap: () => profileChange(),
                            child: Text(
                              "تغییرات",
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
                                "نام کاربر",
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  color: Color(0xFF1C5334),
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "نقش",
                                style: TextStyle(
                                    fontFamily: 'shabnam',
                                    color: Colors.grey,
                                    fontSize: 19),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: ImageIcon(
                              AssetImage('images/account.png'),
                              color: Color(0xFF618771),
                              size: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Divider(
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("tapped");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "تخفیف‌ها",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      child: Divider(
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("tapped");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "تاریخچه سفارش‌ها",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      child: Divider(
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("tapped");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "ارتباط با پشتیبانی",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      child: Divider(
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
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
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text(
                            "خروج",
                            style:
                                TextStyle(fontFamily: 'shabnam', fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      child: Divider(
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
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
                ? Container()
                : Container(
                    child: Column(
                      children: [
                        Scrollbar(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: ImageIcon(
                                              AssetImage('images/remove.png'),
                                              color: Color(0xFF1C5334),
                                              size: 25,
                                            )),
                                        Text(
                                          "تعداد",
                                          style: TextStyle(
                                              fontFamily: 'shabnam',
                                              color: Color(0xFF1C5334),
                                              fontSize: 20),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: ImageIcon(
                                              AssetImage('images/plus.png'),
                                              color: Color(0xFF1C5334),
                                              size: 25,
                                            )),
                                        Expanded(child: Container()),
                                        Column(
                                          children: [
                                            Text(
                                              "نام محصول",
                                              style: TextStyle(
                                                fontFamily: 'shabnam',
                                                color: Color(0xFF1C5334),
                                                fontSize: 23,
                                              ),
                                            ),
                                            Text(
                                              "قیمت",
                                              style: TextStyle(
                                                  fontFamily: 'shabnam',
                                                  color: Color(0xFF1C5334),
                                                  fontSize: 19),
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Image(
                                            image: AssetImage('images/img.png'),
                                            width: 75),
                                        Expanded(child: Container())
                                      ]),
                                    );
                                  },
                                ),
                              )),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "سفارش از [نام فروشگاه]",
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
                            border: TableBorder.all(color: Colors.transparent),
                            textDirection: TextDirection.rtl,
                            children: [
                              TableRow(children: [
                                Container(
                                  child: Text(
                                    'نام محصول',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'shabnam',
                                      fontSize: 20,
                                    ),
                                  ),
                                  height: 50,
                                ),
                                Container(
                                  height: 50,
                                  child: Text(
                                    'قیمت',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'shabnam',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ]),
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
                                      'قیمت',
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
                                      'بسته‌بندی',
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
                                      'قیمت',
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
                                      'قیمت',
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
                                      'قیمت',
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
                                onPressed: () {},
                                child: Text(
                                  "تکمیل",
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
                                  // Navigator.pop(context);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                                },
                                child: Text("ادامه خرید", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), textAlign: TextAlign.center,),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFFFFF),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: Color(0xFF256F46))
                                  ),
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit()));
  }
}
