import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomsheed("آدرس جدید");
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: Color(0xFF256F46),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "انتخاب آدرس",
          style: TextStyle(fontFamily: 'shabnam', fontSize: 25),
        ),
        backgroundColor: Color(0xFF256F46),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          color:
                              selected == 0 ? Color(0xFF2E8B57) : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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

  void bottomsheed(title) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Scaffold(
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: 'نام آدرس',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25),
                        ),
                      ),
                    )),
              ),
              Container(
                height: MediaQuery.of(builder).size.height * 0.30,
                child: Scaffold(
                  body: map(),
                ),
              )
            ]),
            bottomNavigationBar: Container(
              // color: Colors.red,
              height: MediaQuery.of(builder).size.height * 0.085,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1,1),
                    blurRadius: 10,
                    spreadRadius: 5
                  )
                ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child:Text("افزودن آدرس",
                  style: TextStyle(
                    fontSize: 25
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
            )
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ));
  }

  Widget map() {
    return FlutterMap(
        options: MapOptions(
            initialCenter: LatLng(35.715298, 51.404343),
            initialZoom: 11,
            interactionOptions:
                InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom)),
        children: [
          tilelayer,
          MarkerLayer(markers: [
            // Marker(point: point, child: child)
          ])
        ]);
  }
}

TileLayer get tilelayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.blink.example',
    );
