import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductComment extends StatefulWidget {
  const ProductComment({super.key});

  @override
  State<ProductComment> createState() => _ProductCommentState();
}

class _ProductCommentState extends State<ProductComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEAF3EE),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      ImageIcon(
                        AssetImage("images/star.png"),
                        color: Color(0xFF256F46),
                        size: 30,
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
                    padding: const EdgeInsets.only(top: 30),
                    child: ImageIcon(
                      AssetImage("images/product.png"),
                      size: 250,
                      color: Color(0xFF949494),
                    ),
                  ),
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "۳۲۱ امتیاز",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
                            textDirection: TextDirection.rtl,
                          ),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text("نام محصول", style: TextStyle(fontSize: 25),),
                          )
                        ],
                      ),              Padding(
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
}
