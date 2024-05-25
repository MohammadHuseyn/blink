import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../classes/address.dart';
import '../global.dart' as gloabl;
import 'Home.dart';


var name = TextEditingController();
var address = TextEditingController();
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
  void initState() {
    // TODO: implement initState
    _loadAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomsheed("آدرس جدید");
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: const Color(0xFF256F46),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              if (gloabl.addressIndex != null) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Home()));
              } else
                Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: const Text(
          "انتخاب آدرس",
          style: TextStyle(fontFamily: 'shabnam', fontSize: 25),
        ),
        backgroundColor: const Color(0xFF256F46),
      ),
      body: gloabl.addresses.length == 0
          ? const Center()
          : ListView.builder(
              itemCount: gloabl.addresses.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, right: 15, left: 15, top: 5),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                                iconSize: 50,
                                onPressed: () {},
                                icon: const ImageIcon(
                                  AssetImage('images/pencil.png'),
                                  color: Color(0xFFa7afab),
                                )),
                            IconButton(
                                iconSize: 50,
                                onPressed: () {},
                                icon: const ImageIcon(
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
                              color: const Color(0xFFEAF3EE),
                              borderRadius: const BorderRadius.all(Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset:
                                      const Offset(0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Center(
                              child: Text(
                            gloabl.addresses[i].name,
                            style: const TextStyle(fontSize: 30, color: Colors.black),
                          )),
                        ),
                      ],
                    ),
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
                        style: const TextStyle(
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
                              decoration: const InputDecoration(
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
                              maxLines: 3,
                              controller: address,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                labelText: 'آدرس',
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
                                            child: const Icon(
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
                                initialCenter: const LatLng(35.715298, 51.404343),
                                initialZoom: 11,
                                interactionOptions: const InteractionOptions(
                                    flags: InteractiveFlag.all)),
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
                  decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        blurRadius: 10,
                        spreadRadius: 5)
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addAddress(name.text, latlngLocal);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
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
                              (states) => const Color(0xFF256F46))),
                    ),
                  ),
                ));
          });
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ));
  }

  Widget map() {
    return Container();
  }

  Future<void> addAddress(String name, LatLng latLng) async {
    print("Here" + latLng.longitude.toString());
    print(latLng.latitude);
    gloabl.postRequest({
      "name": name,
      "latitude" : latLng.latitude,
      "longitude" : latLng.longitude,
      "id":-1,
      "address"  : address.text
    }, "/locations/");



    gloabl.addresses.clear();
    var res = gloabl.getRequest("/locations/");
    List<Map<String, dynamic>> data = await res;
    data.forEach((element) {
      setState(() {
        gloabl.addressIndex = gloabl.addresses.length;
        gloabl.addresses.add(addres_data(
            name: element["name"],
            latLng: LatLng(double.parse(element["latitude"]),
                double.parse(element["longitude"])),
            id: element["id"],
            desc: element["address"]));
      });
    });

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Address()));
  }

  Future<void> _loadAddresses() async {
    gloabl.addresses.clear();
    var res = gloabl.getRequest("/locations/");
    List<Map<String, dynamic>> data = await res;
    data.forEach((element) {
      setState(() {
        gloabl.addressIndex = gloabl.addresses.length;
        gloabl.addresses.add(addres_data(
            name: element["name"],
            latLng: LatLng(double.parse(element["latitude"]),
                double.parse(element["longitude"])),
            id: element["id"],
            desc: element["address"]));
      });
    });
  }


}

TileLayer get tilelayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.blink.example',
    );
