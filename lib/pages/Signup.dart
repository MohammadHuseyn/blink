import 'dart:ui';

import 'package:blink/pages/Home.dart';
import 'package:blink/pages/Login.dart';
import 'package:blink/pages/SignupScndPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global.dart' as global;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
bool _show_pass = false;
var username = TextEditingController();
var password = TextEditingController();
var check = TextEditingController();
var selectedicon = 'm';

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () {

              if (check.text == password.text) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScndPage(userkind: selectedicon,username: username, password: password)));


              }



            },
            child: Text(
              "  ثبت نام   ",
              style: TextStyle(
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
                    (states) => Color(0xFF256F46))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 35),
                  child: IconButton(
                    icon: Image.asset('images/question.png', width: 48),
                    iconSize: 10,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                  elevation: 5.0,
                                  backgroundColor: Colors.white,
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 100),
                                  contentPadding: EdgeInsets.all(20),
                                  title: ImageIcon(
                                    AssetImage('images/logo.png'),
                                    size: 120,
                                    color: Color(0xFF256F46),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "بلینک برای شما امکان خرید آسان و امن محصولات متنوع را فراهم می‌کند.",
                                              // textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'shabnam',
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "از لباس و الکترونیک تا آرایشی و بهداشتی، همه چیز در یک مکان قابل دسترس است.",
                                              // textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'shabnam',
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "اگر صاحب فروشگاهی این گزینه رو انتخاب کن!",
                                                    // textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontFamily: 'shabnam',
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                // Expanded(child: Container()),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        'images/seller.png'),
                                                    size: 40,
                                                    color: Color(0xFF256F46),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "اگر صاحب فروشگاهی این گزینه رو انتخاب کن!",
                                                    // textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontFamily: 'shabnam',
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                // Expanded(child: Container()),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        'images/people.png'),
                                                    size: 40,
                                                    color: Color(0xFF256F46),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "اگر صاحب فروشگاهی این گزینه رو انتخاب کن!",
                                                    // textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontFamily: 'shabnam',
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                // Expanded(child: Container()),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        'images/motorbike.png'),
                                                    color: Color(0xFF256F46),
                                                    size: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    },
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "ثبت نام",
                        style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF256F46),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, left: 11, top: 35),
                  child: Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "ورود",
                        style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                            color: Color(0xFF256F46)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Color(0xFF256F46))),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            // Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.5),
              child: Container(
                height: 175,
                width: 385,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: -3,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: IconButton(
                              icon: Image.asset('images/motorbike.png',
                                  width: 100),
                              iconSize: 50,
                              onPressed: () {
                                setState(() {
                                  change("p");
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                                boxShadow: selectedicon == "p"
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 30,
                                          spreadRadius: -5,
                                          offset: Offset(0, 0),
                                        )
                                      ]
                                    : null),
                          ),
                          Text(
                            "   پیک   ",
                            style: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 25,
                                color: Color(0xFF256F46)),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: 130,
                        child: VerticalDivider(
                          color: Colors.green,
                        ),
                      ),
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: selectedicon == "m"
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 30,
                                          spreadRadius: -5,
                                          offset: Offset(0, 0),
                                        )
                                      ]
                                    : null),
                            child: IconButton(
                              icon: Image.asset('images/people.png', width: 80),
                              iconSize: 50,
                              onPressed: () {
                                change("m");
                              },
                            ),
                          ),
                          Text(
                            "مشتری",
                            style: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 25,
                                color: Color(0xFF256F46)),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: 130,
                        child: VerticalDivider(
                          color: Colors.green,
                        ),
                      ),
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: selectedicon == "f"
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 30,
                                          spreadRadius: -5,
                                          offset: Offset(0, 0),
                                        )
                                      ]
                                    : null),
                            child: IconButton(
                              icon:
                                  Image.asset('images/seller.png', width: 100),
                              iconSize: 50,
                              onPressed: () {
                                change("f");
                              },
                            ),
                          ),
                          Text(
                            "فروشنده",
                            style: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 25,
                                color: Color(0xFF256F46)),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(child: Container()),
            // Container(child: Material(child: TextField()), width: 500, height: 100,),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: ImageIcon(
                            AssetImage('images/user.png'),
                            size: 35,
                            color: Color(0xFFBDD2C6),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Material(
                            child: Padding(
                              padding: EdgeInsets.only(top: 15, right: 10),
                              child: TextField(
                                controller: username,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'shabnam',
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF256F46), width: 2.0),
                                  ),
                                  hintText: 'نام کاربری',
                                  hintStyle: TextStyle(
                                    height: 1.5,
                                    fontFamily: 'shabnam',
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFEAF3EE),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(17)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF256F46),
                                          width: 10.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: ImageIcon(
                            AssetImage('images/key.png'),
                            size: 35,
                            color: Color(0xFFBDD2C6),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Material(
                            child: Padding(
                              padding: EdgeInsets.only(top: 15, right: 10),
                              child: TextField(
                                controller: password,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'shabnam',
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _show_pass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      // color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _show_pass = !_show_pass;
                                      });
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF256F46), width: 2.0),
                                  ),
                                  hintText: 'رمز عبور',
                                  hintStyle: TextStyle(
                                    height: 1.5,
                                    fontFamily: 'shabnam',
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFEAF3EE),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(17)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF256F46),
                                          width: 10.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.check,
                              size: 35,
                              color: Color(0xFFBDD2C6),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Material(
                            child: Padding(
                              padding: EdgeInsets.only(top: 15, right: 10),
                              child: TextField(
                                controller: check,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'shabnam',
                                ),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _show_pass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      // color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _show_pass = !_show_pass;
                                      });
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF256F46), width: 2.0),
                                  ),
                                  hintText: 'تکرار رمز عبور',
                                  hintStyle: TextStyle(
                                    height: 1.5,
                                    fontFamily: 'shabnam',
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFEAF3EE),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(17)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF256F46),
                                          width: 10.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void change(String s) {
    setState(() {
      selectedicon = s;
    });
  }
}
