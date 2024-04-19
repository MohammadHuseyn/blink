import 'dart:ui';

import 'package:blink/pages/Home.dart';
import 'package:blink/pages/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController? username = new TextEditingController();
    TextEditingController? password = new TextEditingController();
    return Container(
      color: Colors.white,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
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
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: AlertDialog(
                              elevation: 5.0,
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
                              contentPadding: EdgeInsets.all(20),
                              title: ImageIcon(
                                AssetImage('images/logo.png'),
                                size: 120,
                                color: Color(0xFF256F46),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *0.45,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "بلینک برای شما امکان خرید آسان و امن محصولات متنوع را فراهم می‌کند.",
                                          // textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "از لباس و الکترونیک تا آرایشی و بهداشتی، همه چیز در یک مکان قابل دسترس است.",
                                          // textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontFamily: 'shabnam',
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "اگر صاحب فروشگاهی این گزینه رو انتخاب کن",
                                              // textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'shabnam',
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Expanded(child: Container()),
                                            ImageIcon(
                                              AssetImage('images/seller.png'),
                                              size: 40,
                                              color: Color(0xFF256F46),

                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "اگر صاحب فروشگاهی این گزینه رو انتخاب کن",
                                              // textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'shabnam',
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Expanded(child: Container()),
                                            ImageIcon(
                                              AssetImage('images/people.png'),
                                              size: 40,
                                              color: Color(0xFF256F46),

                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "اگر صاحب فروشگاهی این گزینه رو انتخاب کن",
                                              // textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'shabnam',
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Expanded(child: Container()),
                                            ImageIcon(
                                              AssetImage('images/motorbike.png'),
                                              color: Color(0xFF256F46),
                                              size: 40,
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
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text("ثبت نام", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), ),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, top: 35, left: 11),
                  child: Container(
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("ورود", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Colors.white), ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF256F46),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: Colors.transparent,

                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            // Expanded(child: Container()),
            // Container(child: Material(child: TextField()), width: 500, height: 100,),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ImageIcon(
                          AssetImage('images/user.png'),
                          size: 40,
                          color: Color(0xFFBDD2C6),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Material(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15, right: 10),
                          child: TextField(
                            controller: username,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'shabnam',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(17)),
                                borderSide: BorderSide(color: Color(0xFF256F46), width: 2.0),
                              ),
                              hintText: 'نام کاربری',
                              hintStyle: TextStyle(
                                height: 1.5,
                                fontFamily: 'shabnam',
                                fontSize: 25,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Color(0xFFEAF3EE),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                  borderSide: BorderSide(color: Color(0xFF256F46), width: 10.0)),
                            ),
                          ),
                        ),
                      ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: ImageIcon(
                          AssetImage('images/key.png'),
                          size: 40,
                          color: Color(0xFFBDD2C6),
                        ),
                      ),
                      Container(width: 300, height: 100,child: Material(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, right: 10),
                          child: TextField(
                            controller: password,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'shabnam',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(17)),
                                borderSide: BorderSide(color: Color(0xFF256F46), width: 2.0),
                              ),
                              hintText: 'رمز عبور',
                              hintStyle: TextStyle(
                                height: 1.5,
                                fontFamily: 'shabnam',
                                fontSize: 25,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Color(0xFFEAF3EE),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                  borderSide: BorderSide(color: Color(0xFF256F46), width: 10.0)),
                            ),
                          ),
                        ),
                      ),),
                    ],
                  ),
                  TextButton(onPressed: (){}, child: Text("رمز خود را فراموش کردم",
                    style: TextStyle(
                        fontFamily: 'shabnam',
                        fontSize: 17,
                        color: Color(0xFF1818ef),
                      decoration: TextDecoration.underline
                    ),
                  ),
                  )
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20,
                      offset: Offset(1,5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (username.text == 'username' && password.text == 'password') {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                  child: Text("ورود", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Colors.white), ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF256F46),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(50),
                    // ),
                    shadowColor: Colors.black,

                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
