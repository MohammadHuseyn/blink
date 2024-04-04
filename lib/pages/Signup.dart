import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

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
                    onPressed: () {},
                    child: Text("ثبت نام", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Colors.white), ),
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
              Padding(
                padding: const EdgeInsets.only(right: 13, left: 11, top: 35),
                child: Container(
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("ورود", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFFFFF),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Color(0xFF256F46))
                      ),
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 175,
              width: 385,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: -3,
                      blurRadius: 5,
                      offset: Offset(0,5),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('images/motorbike.png', width: 80),
                          iconSize: 10,
                          onPressed: () {},
                  ),
                        Text("پیک", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), ),

                      ],
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    child: VerticalDivider(color: Color(0xFFBEDBCB),),
                  ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('images/seller.png', width: 80),
                          iconSize: 10,
                          onPressed: () {},
                        ),
                        Text("فروشنده", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), ),
                      ],
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    child: VerticalDivider(color: Color(0xFFBEDBCB),),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        IconButton(
                          icon: Image.asset('images/people.png', width: 80),
                          iconSize: 10,
                          onPressed: () {},
                        ),
                        Text("مشتری", style: TextStyle(fontFamily: 'shabnam', fontSize: 20, color: Color(0xFF256F46)), ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(color: Colors.red, width: 100, height: 100,),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
