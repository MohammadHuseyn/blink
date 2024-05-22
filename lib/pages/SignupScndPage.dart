import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blink/pages/DeliveryHomePage.dart';
import 'package:image/image.dart' as img;
import 'package:blink/pages/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../global.dart' as global;
import 'Home.dart';
import 'StoreHomPage.dart';

class SignupScndPage extends StatefulWidget {
  SignupScndPage(
      {required this.userkind, required this.username, required this.password});

  String userkind;
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  State<SignupScndPage> createState() => _SignupScndPageState();
}

LatLng? latlngLocal = null;
List<Marker> markers = [];
var mapc = MapController();
bool isMapRead = false;
class _SignupScndPageState extends State<SignupScndPage> {
  final ImagePicker _picker = ImagePicker();

  File? _imageFile;


  Future<File> cropImageToSquare(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception("Could not decode image.");
    }

    int shortestSide = image.width < image.height ? image.width : image.height;
    int xOffset = (image.width - shortestSide) ~/ 2;
    int yOffset = (image.height - shortestSide) ~/ 2;

    final img.Image croppedImage = img.copyCrop(
      image,
      x: xOffset,
      y: yOffset,
      width: shortestSide,
      height: shortestSide,
    );

    final croppedFile = await imageFile.writeAsBytes(img.encodePng(croppedImage));
    setState(() {
      _imageFile = croppedFile;
    });
    return croppedFile;
  }


  String? base64Image = "";

  var first_name = TextEditingController();

  var last_name = TextEditingController();

  var email = TextEditingController();

  var phone = TextEditingController();

  var shopname = TextEditingController();

  var shopaddress = TextEditingController();

  var pelak = TextEditingController();

  var license = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              // var deli = ;
              // var foro = ;
              // var cust = ;

              var res = global.postRequest(
                  widget.userkind == "f"
                      ? {
                    "username": widget.username.text,
                    "password": widget.password.text,
                    "email": email.text,
                    "first_name": first_name.text,
                    "last_name": last_name.text,
                    "phone_number": phone.text,
                    "user_type": "seller",
                    "longitude": latlngLocal!.longitude,
                    "latitude": latlngLocal!.latitude,
                    // "longitude": "35.715298",
                    // "latitude": "51.404343",
                    "location_name": shopname.text,
                    "store_name": shopname.text,
                    "image" : base64Image,
                    "address" : shopaddress.text
                  }
                      : widget.userkind == "m"
                          ? {
                    "username": widget.username.text,
                    "password": widget.password.text,
                    "email": email.text,
                    "first_name": first_name.text,
                    "last_name": last_name.text,
                    "phone_number": phone.text,
                    // "user_type" : userkind == "f" ? "seller" : userkind == "m"? "customer" : userkind == "p"? "delivery" : null,
                    "user_type": "customer",
                    "longitude": "35.715298",
                    "latitude": "51.404343",
                    "location_name": "usertemplocation",
                    "image" : base64Image,

                  }
                          : {
                    "username": widget.username.text,
                    "password": widget.password.text,
                    "email": email.text,
                    "first_name": first_name.text,
                    "last_name": last_name.text,
                    "phone_number": phone.text,
                    "user_type": "delivery",
                    "image" : base64Image,
                    // "longitude" : "35.715298",
                    // "latitude" : "51.404343",
                    // "location_name" : shopname.text,
                    // "store_name" : shopname.text,
                    "plate": pelak.text,
                    "license": license.text
                  },
                  "/signup/");
              Map<String, dynamic> data = await res;
              global.token = data["token"];
              global.tokenbool = true;
              global.username = data["user"]["username"];
              global.first_name = data["user"]["first_name"];
              global.last_name = data["user"]["last_name"];
              global.email = data["user"]["email"];
              global.userkind = data["user_type"];
              global.phone_number = data["phone_number"];
              global.profile_imge = data["image"];
              switch (global.userkind) {
                case "Seller" : {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHomePage()));
                } break;
                case "Customer" : {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                } break;
                case "Delivery" : {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryHomePage()));

                } break;
              }
              global.tokenbool = true;
              // Navigator.pop(context);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: Text(
              "   تکمیل ثبت نام   ",
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
      appBar: AppBar(
        backgroundColor: Color(0xFF256F46),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 75, // Adjust the radius as needed
                    backgroundColor: Colors.transparent, // Make the background transparent
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75), // Same radius as the CircleAvatar
                      child: Container(
                        width: 150, // Width of the IconButton
                        height: 150, // Height of the IconButton
                        child: IconButton(
                          padding: EdgeInsets.zero, // Remove padding around the icon
                          icon: _imageFile != null
                              ? Image.file(
                            _imageFile!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover, // Ensure the image fills the IconButton
                          )
                              : ImageIcon(
                            AssetImage("images/addimage.png"),
                            color: Color(0xFF1c5334),
                            size: 150, // Size of the ImageIcon
                          ),
                          onPressed: () async {
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                            if (image != null) {
                                (await cropImageToSquare(File(image.path))) as File?;
                              // If you need the base64 string for any purpose
                              List<int> imageBytes = await _imageFile!.readAsBytes();
                              base64Image = base64Encode(imageBytes);
                            } else {
                              print('No image selected.');
                            }
                          },
                          iconSize: 150, // Size of the IconButton
                        ),
                      ),
                    ),
                  ),
                  _imageFile != null? IconButton(
                    icon: Icon(
                      Icons.highlight_remove_rounded, // Use any icon you prefer for deleting the image
                      color: Colors.red, // Change the color if needed
                    ),
                    onPressed: () {
                      setState(() {
                        _imageFile = null; // Set _imageFile to null
                      });
                    },
                    iconSize: 30, // Adjust the size of the icon as needed
                  ) : Container(),

                ],
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
                      controller: widget.username,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: '  نام کاربری  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                      controller: first_name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: '  نام  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                      controller: last_name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: '  نام خانوادگی  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: '  ایمیل  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                      controller: phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: '  تلفن همراه  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            ),
            widget.userkind == 'p'
                ? Padding(
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
                            controller: pelak,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: '  پلاک وسیله نقلیه  ',
                              floatingLabelStyle: TextStyle(fontSize: 25),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 25, fontFamily: 'shabnam'),
                            ),
                          ),
                        )),
                  )
                : Container(),
            widget.userkind == 'p'
                ? Padding(
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
                            controller: license,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: '  کد گواهینامه  ',
                              floatingLabelStyle: TextStyle(fontSize: 25),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 25, fontFamily: 'shabnam'),
                            ),
                          ),
                        )),
                  )
                : Container(),
            widget.userkind == "f"
                ? Padding(
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
                            controller: shopname,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: '  نام فروشگاه  ',
                              floatingLabelStyle: TextStyle(fontSize: 25),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 25, fontFamily: 'shabnam'),
                            ),
                          ),
                        )),
                  )
                : Container(),
            widget.userkind == "f"
                ? Padding(
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
                      controller: shopaddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        labelText: '  آدرس  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior:
                        FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            )
                : Container(),
            widget.userkind == "f"
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Text(
                      "انتخاب فروشگاه روی نقشه",
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                  )
                : Container(),
            widget.userkind == "f"
                ? Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5.0,
                    blurRadius: 7.0,
                  ),
                ],
              ),
              child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: map()),
                )
                : Container(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget map() {
    return Scaffold(
      body: FlutterMap(
        mapController: mapc,
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
              initialZoom: 5,
              interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.pinchZoom)),
          children: [
            tilelayer,
            MarkerLayer(markers: markers)
          ]),
    );
  }

}


TileLayer get tilelayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.blink.example',
    );
