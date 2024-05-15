import 'package:blink/pages/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../global.dart' as global;
import 'Home.dart';
class SignupScndPage extends StatelessWidget {
  SignupScndPage({required this.userkind, required this.username, required this.password});
  String userkind;

  var first_name = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
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
              var deli = {
                "username" : username.text,
                "password" : password.text,
                "email" : email.text,
                "first_name" : first_name.text,
                "last_name" : last_name.text,
                "phone_number" : phone.text,
                "user_type" : "delivery",
                // "longitude" : "35.715298",
                // "latitude" : "51.404343",
                // "location_name" : shopname.text,
                // "store_name" : shopname.text,
                "plate" : pelak.text,
                "license" : license.text
              };
              var foro = {
                "username" : username.text,
                "password" : password.text,
                "email" : email.text,
                "first_name" : first_name.text,
                "last_name" : last_name.text,
                "phone_number" : phone.text,
                "user_type" : "seller",
                "longitude" : "35.715298",
                "latitude" : "51.404343",
                "location_name" : shopname.text,
                "store_name" : shopname.text,
              };
              var cust = {
                "username" : username.text,
                "password" : password.text,
                "email" : email.text,
                "first_name" : first_name.text,
                "last_name" : last_name.text,
                "phone_number" : phone.text,
                // "user_type" : userkind == "f" ? "seller" : userkind == "m"? "customer" : userkind == "p"? "delivery" : null,
                "user_type" : "customer",
                "longitude" : "35.715298",
                "latitude" : "51.404343",
                "location_name" : "usertemplocation",
              };

              var res = global.postRequest(userkind == "f"? foro : userkind == "m"? cust : deli, "/signup/");
              Map<String, dynamic> data = await res;
              global.token = data["token"];
              global.tokenbool = true;
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            child:Text("   تکمیل ثبت نام   ",
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

      appBar: AppBar(
        backgroundColor: Color(0xFF256F46),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageIcon(AssetImage("images/addimage.png"), size: 150, color: Color(0xFF1c5334),),
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
                      controller: username,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        labelText: '  نام کاربری  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            ),Padding(
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
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
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
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            ),

            userkind == 'p'? Padding(
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            ) : Container(),
            userkind == 'p'? Padding(
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            ) : Container(),

            userkind == "f"?
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
                      controller: shopname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        labelText: '  نام فروشگاه  ',
                        floatingLabelStyle: TextStyle(fontSize: 25),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                      ),
                    ),
                  )),
            ): Container(),
            userkind == "f"?
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Text("انتخاب فروشگاه روی نقشه", style: TextStyle(fontSize: 20, color: Colors.black87),),
            ) : Container(),
            userkind == "f"?
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                    offset: Offset(1,5),
                  )
                ]
              ),
                height: MediaQuery.of(context).size.width *0.8,width: MediaQuery.of(context).size.width *0.8,child: map()): Container(),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
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