import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/store.dart';

class StoreComment extends StatefulWidget {
  StoreComment({required this.store});

  Store store;

  @override
  State<StoreComment> createState() => _StoreCommentState(store: store);
}

class _StoreCommentState extends State<StoreComment> {
  _StoreCommentState({required this.store});

  Store store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0,0),
                  blurRadius: 7,
                  spreadRadius: 7
              )
            ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.085,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(context: context, builder: (builder){
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                  );
                });
              },
              child:Text("   ثبت نظر   ",
                style: TextStyle(
                  fontSize: 25,
                ),),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF256F46))
              ),
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
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ImageIcon(
                            AssetImage("images/star.png"),
                            size: 40,
                            color: Color(0xFF256F46),
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
                    Container(
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
                          size: 90,
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
              Column(
                children: [
                  Container(
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
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                "4.1/5",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF256F46)),
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "۱۰ اردیبهشت ۱۴۰۳",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.black87),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("نام کاربر", style: TextStyle(fontSize: 22),),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10,bottom: 45, top: 20),
                          child: Container(
                            child: Text("نظر...",
                              style: TextStyle(fontSize: 25),
                              textDirection: TextDirection.rtl,),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: Color(0xFF7CA990), width: 2))),
                  ),
                  Padding(
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
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "4.1/5",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF256F46)),
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "۱۰ اردیبهشت ۱۴۰۳",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.black87),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("نام کاربر", style: TextStyle(fontSize: 22),),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10,bottom: 45, top: 20),
                            child: Container(
                              child: Text("نظر...",
                                style: TextStyle(fontSize: 25),
                                textDirection: TextDirection.rtl,),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Color(0xFF7CA990), width: 2))),
                    ),
                  ),
                  Padding(
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
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "4.1/5",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF256F46)),
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "۱۰ اردیبهشت ۱۴۰۳",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.black87),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("نام کاربر", style: TextStyle(fontSize: 22),),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10,bottom: 45, top: 20),
                            child: Container(
                              child: Text("نظر...",
                                style: TextStyle(fontSize: 25),
                                textDirection: TextDirection.rtl,),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Color(0xFF7CA990), width: 2))),
                    ),
                  ),
                  Padding(
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
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "4.1/5",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF256F46)),
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "۱۰ اردیبهشت ۱۴۰۳",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.black87),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("نام کاربر", style: TextStyle(fontSize: 22),),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10,bottom: 45, top: 20),
                            child: Container(
                              child: Text("نظر...",
                                style: TextStyle(fontSize: 25),
                                textDirection: TextDirection.rtl,),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Color(0xFF7CA990), width: 2))),
                    ),
                  ),
                  Padding(
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
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "4.1/5",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF256F46)),
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "۱۰ اردیبهشت ۱۴۰۳",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.black87),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("نام کاربر", style: TextStyle(fontSize: 22),),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10,bottom: 45, top: 20),
                            child: Container(
                              child: Text("نظر...",
                                style: TextStyle(fontSize: 25),
                                textDirection: TextDirection.rtl,),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Color(0xFF7CA990), width: 2))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
