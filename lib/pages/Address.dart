import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  var addresses = [];
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "انتخاب آدرس",
          style: TextStyle(fontFamily: 'shabnam', fontSize: 25),
        ),
        backgroundColor: Color(0xFF256F46),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/pencil.png'),
                              color: Color(0xFFa7afab),
                            )),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/trash.png'),
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 120,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: selected == 0 ? Color(0xFF2E8B57) : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Text(
                        "آدرس ۱",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/pencil.png'),
                              color: Color(0xFFa7afab),
                            )),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/trash.png'),
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 120,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: Color(0xFFEAF3EE),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Text(
                        "آدرس ۲",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      )),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/pencil.png'),
                              color: Color(0xFFa7afab),
                            )),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/trash.png'),
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 120,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: Color(0xFFEAF3EE),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Text(
                            "آدرس ۲",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          )),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/pencil.png'),
                              color: Color(0xFFa7afab),
                            )),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/trash.png'),
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 120,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: Color(0xFFEAF3EE),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Text(
                            "آدرس ۲",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          )),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/pencil.png'),
                              color: Color(0xFFa7afab),
                            )),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/trash.png'),
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 120,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: Color(0xFFEAF3EE),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Text(
                            "آدرس ۲",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          )),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/pencil.png'),
                              color: Color(0xFFa7afab),
                            )),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage('images/trash.png'),
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 120,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: Color(0xFFEAF3EE),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Text(
                            "آدرس ۲",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          )),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
