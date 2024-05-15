import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../global.dart' as gloabl;
import 'Home.dart';

class addres_data {
  addres_data({required this.name, required this.latLng});

  late String name;
  late LatLng latLng;
}

var name = TextEditingController();
var latlngLocal = null;

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  var selected = 0;
  List<Marker> markers = [];

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
        leading:
            IconButton(onPressed: () {
              if (gloabl.addressIndex != null) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              } else Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_outlined)),
        title: Text(
          "انتخاب آدرس",
          style: TextStyle(fontFamily: 'shabnam', fontSize: 25),
        ),
        backgroundColor: Color(0xFF256F46),
      ),
      body: gloabl.addresses.length == 0
          ? Center()
          : ListView.builder(
              itemCount: gloabl.addresses.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, right: 15, left: 15, top: 5),
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
                          gloabl.addresses[i].name,
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void bottomsheed(title) {
    markers.clear();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Scaffold(
                body: SingleChildScrollView(
                  child: Column(children: [
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
                            child: TextField(
                              controller: name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                labelText: 'نام آدرس',
                                floatingLabelStyle: TextStyle(fontSize: 25),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    fontSize: 25, fontFamily: 'shabnam'),
                              ),
                            ),
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(builder).size.height * 0.30,
                      child: Scaffold(
                        body: FlutterMap(
                            options: MapOptions(
                                onTap: (tap_position, latlng) {
                                  latlngLocal = latlng;
                                  // print('Tapped at: $latlng');
                                  // Clear existing markers
                                  setState(() {
                                    setState(() {
                                      markers.clear();
                                      markers.add(
                                        Marker(
                                          width: 80.0,
                                          height: 80.0,
                                          point: latlng,
                                          // Child parameter instead of builder
                                          // Directly using an Icon as the child
                                          child: Container(
                                            child: Icon(
                                              Icons.location_pin,
                                              color: Colors.red,
                                              size: 40.0,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                    // Add a marker for the tapped location
                                  });
                                },
                                initialCenter: LatLng(35.715298, 51.404343),
                                initialZoom: 11,
                                interactionOptions: InteractionOptions(
                                    flags: InteractiveFlag.pinchZoom)),
                            children: [
                              tilelayer,
                              MarkerLayer(markers: markers)
                            ]),
                      ),
                    )
                  ]),
                ),
                bottomNavigationBar: Container(
                  // color: Colors.red,
                  height: MediaQuery.of(builder).size.height * 0.085,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        blurRadius: 10,
                        spreadRadius: 5)
                  ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addAddress(name.text, latlngLocal);
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "افزودن آدرس",
                        style: TextStyle(fontSize: 25),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF256F46))),
                    ),
                  ),
                ));
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ));
  }

  void _handleTap(LatLng latlng) {}

  Widget map() {
    return Container();
  }

  void addAddress(String name, LatLng latLng) {
    setState(() {
      gloabl.addressIndex = gloabl.addresses.length;
      gloabl.addresses.add(addres_data(name: name, latLng: latLng));
    });
    // Navigator.pop(context);
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
  }
}

TileLayer get tilelayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.blink.example',
    );
