import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global.dart' as global;
class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

var username = TextEditingController();
var first_name = TextEditingController();
var email = TextEditingController();
var last_name = TextEditingController();
var phone = TextEditingController();
var store_name = TextEditingController();
var newpass = TextEditingController();
var duppass = TextEditingController();
var showPass = false;
var currPass = TextEditingController();
class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    username.text = global.username;
    first_name.text = global.first_name;
    last_name.text = global.last_name;
    first_name.text = global.first_name;
    email.text = global.email;
    phone.text = global.phone_number;
    store_name.text = global.storeName;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () {
              if (newpass.text == duppass.text) {
                  global.putRequest({
                    "first_name" : first_name.text,
                    "last_name" : last_name.text,
                    "email" : email.text,
                    "current_password" : currPass.text,
                    "password" : newpass.text
                  }, '/customer_edit_profile/');
              }
            },
            child: Text(
              "  ثبت تغییرات   ",
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
        elevation: 0,
        backgroundColor: Color(0xFF256F46),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: ImageIcon(
                  AssetImage('images/account.png'),
                  color: Color(0xFF618771),
                  size: 80,
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
                        readOnly: true,
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
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              global.userkind == "Seller"? Padding(
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
                        controller: store_name,
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
              ) : Container(),
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
                        readOnly: true,
                        controller: phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  شماره تلفن  ',
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
                        controller: currPass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  رمز فعلی  ',
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
                        obscureText: !showPass,
                        controller: newpass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              showPass = !showPass;
                            });
                          }, icon: Icon(Icons.remove_red_eye)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  رمز جدید  ',
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
                        obscureText: !showPass,
                        controller: duppass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              showPass = !showPass;
                            });
                          }, icon: Icon(Icons.remove_red_eye)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: ' تکرار رمز جدید  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
