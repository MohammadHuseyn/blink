import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

var showPass = false;
var currPass = TextEditingController();
class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: const TextField(
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
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  نام و نام خانوادگی  ',
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
                      child: const TextField(
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
                        obscureText: !showPass,
                        controller: currPass,
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
                      child: const TextField(
                        decoration: InputDecoration(
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
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  تکرار رمز جدید  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child:Text("   ثبت تغییرات   ",
                    style: TextStyle(
                        fontSize: 20,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
