import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/classes/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/item.dart';
import '../classes/store.dart';
import '../global.dart' as global;
import 'CommentRateSent.dart';

class ProductComment extends StatefulWidget {
  ProductComment({required this.item});

  Item item;

  @override
  State<ProductComment> createState() => _ProductCommentState(item: item);
}

var comment = TextEditingController();

class _ProductCommentState extends State<ProductComment> {
  _ProductCommentState({required this.item});

  Item item;

  @override
  void initState() {
    // TODO: implement initState
    _load_comments(item);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 7)
          ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.085,
              child: ElevatedButton(
                onPressed: () async {
                  var width = MediaQuery.of(context).size.width * 0.9;
                  var height = MediaQuery.of(context).size.height * 0.8;
                  var rate = 0;
                  var star = AssetImage("images/star.png");
                  var empty_star = AssetImage("images/star_empty.png");
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return StatefulBuilder(
                            builder: (context, StateSetter setstate2) {
                          return Center(
                            child: Container(
                              width: width,
                              height: height,
                              child: Material(
                                borderRadius: BorderRadius.circular(50),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 50),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 35),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setstate2(() {
                                                    rate = 1;
                                                  });
                                                  // setRate(1);
                                                },
                                                icon: ImageIcon(
                                                  rate >= 1 ? star : empty_star,
                                                  color: Color(0xFF256F46),
                                                  size: 50,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setstate2(() {
                                                    rate = 2;
                                                  });
                                                  // setRate(2);
                                                },
                                                icon: ImageIcon(
                                                  rate >= 2 ? star : empty_star,
                                                  color: Color(0xFF256F46),
                                                  size: 50,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setstate2(() {
                                                    rate = 3;
                                                  });
                                                  // setRate(3);
                                                },
                                                icon: ImageIcon(
                                                  rate >= 3 ? star : empty_star,
                                                  color: Color(0xFF256F46),
                                                  size: 50,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setstate2(() {
                                                    rate = 4;
                                                  });
                                                  // setRate(4);
                                                },
                                                icon: ImageIcon(
                                                  rate >= 4 ? star : empty_star,
                                                  color: Color(0xFF256F46),
                                                  size: 50,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setstate2(() {
                                                    rate = 5;
                                                  });
                                                  // setRate(4);
                                                },
                                                icon: ImageIcon(
                                                  rate >= 5 ? star : empty_star,
                                                  color: Color(0xFF256F46),
                                                  size: 50,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 35),
                                        child: Text(
                                          "نظر خود را بنویسید",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            right: 20,
                                            left: 20,
                                            bottom: 20),
                                        child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: TextField(
                                              textInputAction:
                                                  TextInputAction.newline,
                                              maxLines: 5,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              controller: comment,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  height: 2.0,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                // contentPadding: EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.teal),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                labelText:
                                                    '  نظر خود را بنویسید  ',
                                                floatingLabelStyle:
                                                    TextStyle(fontSize: 25),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                labelStyle: TextStyle(
                                                    fontSize: 25,
                                                    fontFamily: 'shabnam'),
                                              ),
                                            )),
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 5),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.085,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "   بیخیال   ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xFF256F46))),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) =>
                                                                    Colors
                                                                        .white)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 5),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.085,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  global.postRequest(
                                                      {
                                                        "rate": rate,
                                                        "comment": comment.text,
                                                        // "user_id" : global
                                                      },
                                                      "/product-comments/?product_id=" +
                                                          item.id);
                                                  _load_comments(item);
                                                  _load_comments(item);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              CommentRateSent()));
                                                },
                                                child: Text(
                                                  "   ثبت نظر   ",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) => Color(
                                                                    0xFF256F46))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Expanded(child: Container(
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Text(
                  "   ثبت نظر   ",
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
        ),
        backgroundColor: Color(0xFFEAF3EE),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 50),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      IconButton(
                        onPressed: () {
                          var width = MediaQuery.of(context).size.width * 0.9;
                          var height = MediaQuery.of(context).size.height * 0.4;
                          var rate = 0;
                          var star = AssetImage("images/star.png");
                          var empty_star = AssetImage("images/star_empty.png");

                          showDialog(
                              context: context,
                              builder: (builder) {
                                return StatefulBuilder(
                                    builder: (context, StateSetter setstate2) {
                                  return Center(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 50),
                                          child: Column(
                                            children: [
                                              Text(
                                                "به این محصول چه امتیازی می‌دهید؟",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Expanded(child: Container()),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 35),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          setstate2(() {
                                                            rate = 1;
                                                          });
                                                          // setRate(1);
                                                        },
                                                        icon: ImageIcon(
                                                          rate >= 1
                                                              ? star
                                                              : empty_star,
                                                          color:
                                                              Color(0xFF256F46),
                                                          size: 50,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          setstate2(() {
                                                            rate = 2;
                                                          });
                                                          // setRate(2);
                                                        },
                                                        icon: ImageIcon(
                                                          rate >= 2
                                                              ? star
                                                              : empty_star,
                                                          color:
                                                              Color(0xFF256F46),
                                                          size: 50,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          setstate2(() {
                                                            rate = 3;
                                                          });
                                                          // setRate(3);
                                                        },
                                                        icon: ImageIcon(
                                                          rate >= 3
                                                              ? star
                                                              : empty_star,
                                                          color:
                                                              Color(0xFF256F46),
                                                          size: 50,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          setstate2(() {
                                                            rate = 4;
                                                          });
                                                          // setRate(4);
                                                        },
                                                        icon: ImageIcon(
                                                          rate >= 4
                                                              ? star
                                                              : empty_star,
                                                          color:
                                                              Color(0xFF256F46),
                                                          size: 50,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          setstate2(() {
                                                            rate = 5;
                                                          });
                                                          // setRate(4);
                                                        },
                                                        icon: ImageIcon(
                                                          rate >= 5
                                                              ? star
                                                              : empty_star,
                                                          color:
                                                              Color(0xFF256F46),
                                                          size: 50,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 20,
                                                            horizontal: 5),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.085,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "   بیخیال   ",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  side: BorderSide(
                                                                      color: Color(
                                                                          0xFF256F46))),
                                                            ),
                                                            backgroundColor:
                                                                MaterialStateColor
                                                                    .resolveWith(
                                                                        (states) =>
                                                                            Colors.white)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 20,
                                                            horizontal: 5),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.085,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (builder) =>
                                                                          CommentRateSent()));
                                                        },
                                                        child: Text(
                                                          "   ثبت   ",
                                                          style: TextStyle(
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                MaterialStateColor
                                                                    .resolveWith(
                                                                        (states) =>
                                                                            Color(0xFF256F46))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Expanded(child: Container(
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              });
                        },
                        iconSize: 40,
                        icon: ImageIcon(
                          AssetImage("images/star.png"),
                          color: Color(0xFF256F46),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "4.1",
                          style:
                              TextStyle(fontSize: 25, color: Color(0xFF256F46)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    color: Color(0xFFEAF3EE),
                    // color: Colors.red,
                    height: 200,
                    // width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: global.profile_imge == ""
                            ? ImageIcon(
                                AssetImage("images/shop.png"),
                                size: 250,
                                color: Color(0xFF949494),
                              )
                            : ClipRRect(
                                // borderRadius: BorderRadius.circular(75),
                                // Same radius as the CircleAvatar
                                child: Image.memory(
                                  width: 200,
                                  Uint8List.fromList(
                                      base64Decode(global.profile_imge)),
                                  fit: BoxFit
                                      .fitWidth, // Adjust the fit as needed
                                ),
                              ))),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "۳۲۱ امتیاز",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                          textDirection: TextDirection.rtl,
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            "نام محصول",
                            style: TextStyle(fontSize: 25),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFF7CA990), width: 2))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 10, left: 10),
                          child: Row(
                            children: [
                              Text(
                                "۶۵ نظر",
                                textDirection: TextDirection.rtl,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "نظرات کاربران",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Expanded(
                      child: ListView.builder(
                          itemCount: item.comments.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage("images/star.png"),
                                          color: Color(0xFF256F46),
                                          size: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Text(
                                            "4.1/5",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF256F46)),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          item.comments[i].date,
                                          textDirection: TextDirection.rtl,
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            item.comments[i].name,
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 45,
                                          top: 20),
                                      child: Container(
                                        child: Text(
                                          item.comments[i].comment,
                                          style: TextStyle(fontSize: 25),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFF7CA990),
                                            width: 2))),
                              ),
                            );
                          }),
                    )),
                  ],
                )),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
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
        ));
  }

  Future<void> _load_comments(Item item) async {
    var res = global.getRequest("/product-comments/?product_id=" + item.id);
    List<Map<String, dynamic>> data = await res;
    setState(() {
      data.forEach((element) {
        item.comments.add(Comment(
          rate: element["rate"],
            comment: element["comment"],
            name: element["user_first_name"] + " " + element["user_last_name"],
            date: element["comment_created"]));
      });
    });
  }
}
