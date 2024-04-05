import 'package:blink/pages/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 35),
                child: IconButton(
                  icon: Image.asset('images/question.png', width: 48),
                  iconSize: 10,
                  onPressed: () {},
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Container(
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text("ثبت نام", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFFFFF),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFF256F46))
                      ),
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13, top: 35, left: 11),
                child: Container(
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("ورود", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Colors.white), ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF256F46),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.transparent,

                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          // Expanded(child: Container()),
          // Container(child: Material(child: TextField()), width: 500, height: 100,),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ImageIcon(
                        AssetImage('images/user.png'),
                        size: 40,
                        color: Color(0xFFBDD2C6),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: const Material(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15, right: 10),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                            hintText: 'نام کاربری',
                            hintStyle: TextStyle(
                              height: 2.7,
                              fontFamily: 'shabnam',
                                fontSize: 25,
                                color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Color(0xFFEAF3EE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(17)),
                                borderSide: BorderSide(color: Color(0xFF256F46), width: 10.0)),
                          ),
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'shabnam',
                          ),
                        ),
                      ),
                    ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: ImageIcon(
                        AssetImage('images/key.png'),
                        size: 40,
                        color: Color(0xFFBDD2C6),
                      ),
                    ),
                    Container(width: 300, height: 100,child: const Material(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, right: 10),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                            hintText: 'رمز عبور',
                            hintStyle: TextStyle(
                              height: 2.7,
                              fontFamily: 'shabnam',
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Color(0xFFEAF3EE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(17)),
                                borderSide: BorderSide(color: Color(0xFF256F46), width: 10.0)),
                          ),
                         style: TextStyle(
                           fontSize: 25,
                           fontFamily: 'shabnam'
                         ),
                        ),
                      ),
                    ),),
                  ],
                ),
                TextButton(onPressed: (){}, child: Text("رمز خود را فراموش کردم",
                  style: TextStyle(
                      fontFamily: 'shabnam',
                      fontSize: 17,
                      color: Color(0xFF1818ef),
                    decoration: TextDecoration.underline
                  ),
                ),
                )
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                    offset: Offset(1,5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("ثبت نام", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Colors.white), ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF256F46),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                  shadowColor: Colors.black,

                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
