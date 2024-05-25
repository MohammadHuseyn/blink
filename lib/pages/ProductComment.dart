import 'dart:convert';
import 'dart:typed_data';

import 'package:blink/classes/comment.dart';
import 'package:flutter/material.dart';
import '../classes/item.dart';
import '../global.dart' as global;
import 'CommentRateSent.dart';

// committing
class ProductComment extends StatefulWidget {
  ProductComment({super.key, required this.item});

  Item item;

  @override
  State<ProductComment> createState() => _ProductCommentState(item: item);
}

var comment = TextEditingController();

class _ProductCommentState extends State<ProductComment> {
  _ProductCommentState({required this.item});

  Item item;
  bool got_data = true;
  @override
  void initState() {
    // TODO: implement initState
    _load_comments(item);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: global.userKind == "Seller"? null :Container(
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 7)
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.085,
              child: ElevatedButton(
                onPressed: () async {
                  var width = MediaQuery.of(context).size.width * 0.9;
                  var height = MediaQuery.of(context).size.height * 0.8;
                  var rate = 0;
                  var star = const AssetImage("images/star.png");
                  var emptyStar = const AssetImage("images/star_empty.png");
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return StatefulBuilder(
                            builder: (context, StateSetter setstate2) {
                          return Center(
                            child: SizedBox(
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
                                                  rate >= 1 ? star : emptyStar,
                                                  color: const Color(0xFF256F46),
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
                                                  rate >= 2 ? star : emptyStar,
                                                  color: const Color(0xFF256F46),
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
                                                  rate >= 3 ? star : emptyStar,
                                                  color: const Color(0xFF256F46),
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
                                                  rate >= 4 ? star : emptyStar,
                                                  color: const Color(0xFF256F46),
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
                                                  rate >= 5 ? star : emptyStar,
                                                  color: const Color(0xFF256F46),
                                                  size: 50,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
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
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  height: 2.0,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
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
                                            padding: const EdgeInsets.symmetric(
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
                                                child: const Text(
                                                  "   بیخیال   ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
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
                                                          side: const BorderSide(
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
                                            padding: const EdgeInsets.symmetric(
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
                                                  // _load_comments(item);
                                                  await Future.delayed(const Duration(milliseconds: 500));
                                                  _load_comments(item);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              const CommentRateSent()));
                                                },
                                                child: const Text(
                                                  "   ثبت نظر   ",
                                                  style: TextStyle(
                                                    fontSize: 20,
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
                                                                (states) => const Color(
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
                child: const Text(
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
                        (states) => const Color(0xFF256F46))),
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFFEAF3EE),
        body: Stack(
          children: [
            PreferredSize(
                preferredSize: const Size.fromHeight(150.0),
                child: Container(
                  color: const Color(0xFFEAF3EE),
                  // color: Colors.red,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: item.image == ""
                      ? const ImageIcon(
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
                          base64Decode(item.image)),
                      fit: BoxFit.fitWidth, // Adjust the fit as needed
                    ),
                  ),
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Row(
                    children: [
                      IconButton(onPressed: (){

                        var width = MediaQuery.of(context).size.width * 0.9;
                        var height = MediaQuery.of(context).size.height * 0.4;
                        var rate = 0;
                        var star = const AssetImage("images/star.png");
                        var emptyStar = const AssetImage("images/star_empty.png");
                        if (global.userKind != "Seller")
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return StatefulBuilder(
                                  builder: (context, StateSetter setstate2) {
                                    return Center(
                                      child: SizedBox(
                                        width: width,
                                        height: height,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 50),
                                            child: Column(
                                              children: [
                                                const Text(
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
                                                                : emptyStar,
                                                            color:
                                                            const Color(0xFF256F46),
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
                                                                : emptyStar,
                                                            color:
                                                            const Color(0xFF256F46),
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
                                                                : emptyStar,
                                                            color:
                                                            const Color(0xFF256F46),
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
                                                                : emptyStar,
                                                            color:
                                                            const Color(0xFF256F46),
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
                                                                : emptyStar,
                                                            color:
                                                            const Color(0xFF256F46),
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
                                                      const EdgeInsets.symmetric(
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
                                                          child: const Text(
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
                                                                    side: const BorderSide(
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
                                                      const EdgeInsets.symmetric(
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
                                                                        const CommentRateSent()));
                                                          },
                                                          child: const Text(
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
                                                                      const Color(0xFF256F46))),
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
                      }, icon: const ImageIcon(AssetImage("images/star.png"), color: Color(0xFF256F46),), iconSize: 35,),
                      Text(global.toPersianNumbers(item.rate) + "/۵", style: const TextStyle(fontSize: 18, color: Color(0xFF256F46)),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: const BoxDecoration(
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
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 15),
                                child: Container(
                                  width: 100,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(75)
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    global.toPersianNumbers(item.comments.length) + " امتیاز",
                                    style: TextStyle(fontSize: 20, color: Colors.black54),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Expanded(child: Container()),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF7CA990), width: 2))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          global.toPersianNumbers(item.comments.length) + " نظر",
                                          textDirection: TextDirection.rtl,
                                          style:
                                              TextStyle(color: Colors.grey, fontSize: 18),
                                        ),
                                        Expanded(child: Container()),
                                        const Text(
                                          "نظرات کاربران",
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              !got_data? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.2,
                                    ),
                                    const CircularProgressIndicator(
                                      backgroundColor: Colors.lightGreen,
                                      color: Color(0xFF256F46),
                                      strokeWidth: 5,
                                      strokeAlign: 2,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "در حال دریافت کامنت‌ها",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 30, color: Color(0xFF256F46)),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.2,
                                    ),
                                  ],
                                ),
                              ) : item.comments.isEmpty? Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.3,
                                  ),
                                  const Center(
                                    child: Text("کامنتی وجود ندارد",style: TextStyle(fontSize: 20),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: IconButton(
                                        onPressed: () async {
                                          // _load_orders(store);
                                          await Future.delayed(const Duration(milliseconds: 500));
                                          _load_comments(item);
                                        },
                                        icon: const Icon(Icons.refresh)),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.3,
                                  ),
                                ],
                              ) : ListView.builder(
    shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: item.comments.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const ImageIcon(
                                              AssetImage("images/star.png"),
                                              color: Color(0xFF256F46),
                                              size: 30,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                global.toPersianNumbers(item.comments[i].rate) + "/۵",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF256F46)),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                item.comments[i].name,
                                                style: const TextStyle(fontSize: 22),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(
                                            item.comments[i].date,
                                            textDirection: TextDirection.rtl,
                                            style:
                                            const TextStyle(color: Colors.black87),
                                          ),
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
                                              style: const TextStyle(fontSize: 25),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFF7CA990),
                                                width: 2))),
                                  ),
                                );
                              }),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _load_comments(Item item) async {
    setState(() {
      got_data = false;
    });
    var res = global.getRequest("/product-comments/?product_id=" + item.id);
    List<Map<String, dynamic>> data = await res;
    setState(() {
      data.forEach((element) {
        item.comments.add(Comment(
          rate: double.parse(element["rate"]),
            comment: element["comment"],
            name: element["user_first_name"] + " " + element["user_last_name"],
            date: element["comment_created"]));
      });
    });
    setState(() {
      got_data = true;
    });
  }


}
