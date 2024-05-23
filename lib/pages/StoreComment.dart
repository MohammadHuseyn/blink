import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/classes/comment.dart';
import 'package:blink/pages/CommentRateSent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global.dart' as global;
import '../classes/store.dart';

class StoreComment extends StatefulWidget {
  StoreComment({required this.store});

  Store store;

  @override
  State<StoreComment> createState() => _StoreCommentState(store: store);
}

class _StoreCommentState extends State<StoreComment> {
  _StoreCommentState({required this.store});
  var comment = TextEditingController();

  Store store;

  @override
  void initState() {
    _load_comments(store);
    // TODO: implement initState
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
                                            // controller: ,
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
                                                          Radius.circular(15))),
                                              labelText:
                                                  '  نظر خود را بنویسید  ',
                                              floatingLabelStyle:
                                                  TextStyle(fontSize: 25),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
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
                                                  shape:
                                                      MaterialStateProperty.all<
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
                                                              (states) => Colors
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
                                                    "/store-comments/?store_id=" +
                                                        store.id);
                                                await Future.delayed(Duration(milliseconds: 500));
                                                _load_comments(store);
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
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
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
      appBar: AppBar(
        // centerTitle: true,
        // title: Text(store.name),
        backgroundColor: Color(0xFF256F46),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: IconButton(
                            onPressed: () {
                              var width =
                                  MediaQuery.of(context).size.width * 0.9;
                              var height =
                                  MediaQuery.of(context).size.height * 0.4;
                              var rate = 0;
                              var star = AssetImage("images/star.png");
                              var empty_star =
                                  AssetImage("images/star_empty.png");

                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return StatefulBuilder(builder:
                                        (context, StateSetter setstate2) {
                                      return Center(
                                        child: Container(
                                          width: width,
                                          height: height,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 50),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "به این فروشگاه چه امتیازی می‌دهید؟",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 35),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              color: Color(
                                                                  0xFF256F46),
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
                                                              color: Color(
                                                                  0xFF256F46),
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
                                                              color: Color(
                                                                  0xFF256F46),
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
                                                              color: Color(
                                                                  0xFF256F46),
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
                                                              color: Color(
                                                                  0xFF256F46),
                                                              size: 50,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20,
                                                                horizontal: 5),
                                                        child: SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.085,
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "   بیخیال   ",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                            style: ButtonStyle(
                                                                shape: MaterialStateProperty
                                                                    .all<
                                                                        RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      side: BorderSide(
                                                                          color:
                                                                              Color(0xFF256F46))),
                                                                ),
                                                                backgroundColor:
                                                                    MaterialStateColor.resolveWith(
                                                                        (states) =>
                                                                            Colors.white)),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20,
                                                                horizontal: 5),
                                                        child: SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.085,
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
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
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                                backgroundColor:
                                                                    MaterialStateColor.resolveWith(
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
                        ),
                        Text(
                          "4.1/5",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "۳۲۱ امتیاز",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Text(
                      store.name,
                      style: TextStyle(fontSize: 25),
                    ),
                    Expanded(child: Container()),
                    global.profile_imge == ""
                        ? Container(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: ImageIcon(
                                  AssetImage("images/shop.png"),
                                  size: 60,
                                )))
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              // Same radius as the CircleAvatar
                              child: Image.memory(
                                width: 100,
                                Uint8List.fromList(
                                    base64Decode(global.profile_imge)),
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFF7CA990), width: 2))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, right: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "۶۵ نظر",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
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
              store.comments.length == 0? Container() : Container(
                height: 400,
                child: ListView.builder(
                    itemCount: store.comments.length,
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
                                  // Expanded(child: Container()),
                                  Text(
                                    store.comments[i].date,
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(color: Colors.black87),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      store.comments[i].name,
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
                                    store.comments[i].comment,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _load_comments(Store store) async {
    var res = global.getRequest("/store-comments/?store_id=" + store.id);
    List<Map<String, dynamic>> data = await res;
    setState(() {
      data.forEach((element) {
        store.comments.add(Comment(
            rate: double.parse(element["rate"]),
            comment: element["comment"],
            name: element["user_first_name"] + " " + element["user_last_name"],
            date: element["comment_created"]));
      });
    });
  }
}
