import 'dart:ffi';
import 'dart:ui';
import 'package:blink/classes/item.dart';
import 'package:blink/pages/DeliveryHomePage.dart';
import 'package:blink/pages/StoreHomPage.dart';

import '../global.dart' as global;
import 'package:blink/pages/Home.dart';
import 'package:blink/pages/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'StorePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

var username = TextEditingController();
var password = TextEditingController();
bool _show_pass = false;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              // if (username.text == 'username' && password.text == 'password') {
              //   Navigator.pop(context);
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              // }
              try {
                var res = global.postRequest(
                    {'username': username.text, 'password': password.text},
                    "/login/");
                try {
                  Map<String, dynamic> data = await res;
                  global.token = data["token"];
                  global.tokenbool = true;
                  global.username = data["user"]["username"];
                  global.first_name = data["user"]["first_name"];
                  global.last_name = data["user"]["last_name"];
                  global.email = data["user"]["email"];
                  global.userkind = data["user_type"];
                  global.phone_number = data["phone_number"];
                  global.profile_imge =
                  data["image"] == null ? "" : data["image"];
                  switch (global.userkind) {
                    case "Seller":
                      {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoreHomePage()));
                      }
                      break;
                    case "Customer":
                      {
                        _load_order();
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                      break;
                    case "Delivery":
                      {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryHomePage()));
                      }
                      break;
                  }
                } catch (e) {
                  print('Error: $e');
                }
              } on Exception catch (e) {
                global.toast(context, "نام کاربری یا رمز عبور اشتباه می‌باشد");
                // TODO
              }

            },
            child: Text(
              "   ورود   ",
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
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
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
                                                padding: const EdgeInsets.only(
                                                    left: 5),
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
                                                padding: const EdgeInsets.only(
                                                    left: 5),
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
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
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
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text(
                      "ثبت نام",
                      style: TextStyle(
                          fontFamily: 'shabnam',
                          fontSize: 20,
                          color: Color(0xFF256F46)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFFFFF),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFF256F46))),
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13, top: 35, left: 11),
                child: Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "ورود",
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
                      size: 35,
                      color: Color(0xFFBDD2C6),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Material(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15, right: 10),
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
                                    color: Color(0xFF256F46), width: 10.0)),
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
                  Padding(
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
                                    color: Color(0xFF256F46), width: 10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "رمز خود را فراموش کردم",
                    style: TextStyle(
                        fontFamily: 'shabnam',
                        fontSize: 17,
                        color: Color(0xFF1818ef),
                        decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Future<void> _load_order() async {
    var res = global.getRequest("/customer_orders/");
    List<Map<String, dynamic>> data = await res;
    if (data.isEmpty) {
      global.card.clear();
      global.currentCardPayement = false;
    }
    Map<String, dynamic> order = data[0];
    global.order_id = order["order_id"];
    List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(order["order_items"]);
    items.forEach((element) {
      Item item = Item(
          sotreid: order["store_id"].toString(),
          id: element["id"].toString(),
          rate: double.parse(element["product"]["rate"]),
          name: element["product"]["name"],
          desc: "",
          image: element["product"]["image"],
          price: double.parse(element["product"]["price"]));
      item.count = element["quantity"];
      global.card.add(item);
    });
    global.currentCardPayement = true;
    global.currentley_running_order = true;
    global.sum = order["total_price"];
  }
}
