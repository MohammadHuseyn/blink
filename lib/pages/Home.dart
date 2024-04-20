import 'package:blink/pages/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

var _currentIndex = 1;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08), // here the desired height
        child: AppBar(
          elevation: 0,
          backgroundColor: _currentIndex == 0? Color(0xFF256F46):Colors.white,
          actions: _currentIndex == 1? [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.notifications, size: 50,color: Color(0xFF256F46),)),
            )
          ] : [],
          leading: _currentIndex == 1? Padding(
            padding: const EdgeInsets.only(left: 2),
            child: IconButton(
              icon: Icon(Icons.location_on, size: 50, color: Color(0xFF256F46),),
              onPressed: () {},
            ),
          ): null,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF256F46),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 40
      ),
      selectedIconTheme: IconThemeData(
        color: Color(0xFF256F46),
        size: 50
      ), currentIndex: _currentIndex,
      onTap: (index) {
          changeBottomIndex(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Column(
            children: [
              ImageIcon(AssetImage('images/user2.png'),color: Colors.white,),
              SizedBox(height: 10,),
              Divider(height: 0.5,color: _currentIndex == 0? Colors.white:Color(0xFF256F46) ,thickness: 2.5,indent: 30,endIndent: 30,)
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              ImageIcon(AssetImage('images/home.png'),color: Colors.white,),
              SizedBox(height: 10,),
              Divider(height: 0.5,color: _currentIndex == 1? Colors.white:Color(0xFF256F46) ,thickness: 2.5,indent: 30,endIndent: 30,)
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(AssetImage('images/cart.png'),color: Colors.white,),
              SizedBox(height: 10,),
              Divider(height: 0.5,color: _currentIndex == 2? Colors.white:Color(0xFF256F46) ,thickness: 2.5,indent: 37,endIndent: 30,)
            ],
          ),
          label: '',
        ),
      ],
    ),
  body: _currentIndex == 0?
  Container(
    child: Column(
      children: [
        // Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Row(
            children: [
              IconButton(onPressed: (){

              }, icon: Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xFF1C5334),
                size: 35,
              )),
              Text("تغییرات", style: TextStyle(
                fontFamily: 'shabnam',
                color: Color(0xFF1C5334),
                fontSize: 20
              ),),
              Expanded(child: Container()),
              Column(
                children: [
                  Text("نام کاربر", style: TextStyle(
                      fontFamily: 'shabnam',
                      color: Color(0xFF1C5334),
                    fontSize: 25,
                  ),),
                  Text("نقش", style: TextStyle(
                      fontFamily: 'shabnam',
                      color: Colors.grey,
                    fontSize: 19
                  ),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: ImageIcon(AssetImage('images/account.png'),
                  color: Color(0xFF618771),
                size: 80,),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Divider(color: Colors.black,indent: 20,endIndent: 20,),
        ),
        GestureDetector(
            behavior: HitTestBehavior.translucent,
          onTap: (){print("tapped");},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.03,
            child: Center(
              child: Text(
                "تخفیف‌ها",
                style: TextStyle(
                  fontFamily: 'shabnam',
                  fontSize: 20
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 30),
          child: Divider(color: Colors.black,indent: 20,endIndent: 20,),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){print("tapped");},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.03,
            child: Center(
            child: Text(
              "تاریخچه سفارش‌ها",
              style: TextStyle(
                  fontFamily: 'shabnam',
                  fontSize: 20
              ),
            ),
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 30),
          child: Divider(color: Colors.black,indent: 20,endIndent: 20,),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){print("tapped");},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.03,
            child: Center(
              child: Text(
                "ارتباط با پشتیبانی",
                style: TextStyle(
                    fontFamily: 'shabnam',
                    fontSize: 20
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 30),
          child: Divider(color: Colors.black,indent: 20,endIndent: 20,),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            print("logged out");
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.03,
            child: Center(
              child: Text(
                "خروج",
                style: TextStyle(
                    fontFamily: 'shabnam',
                    fontSize: 20
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 30),
          child: Divider(color: Colors.black,indent: 20,endIndent: 20,),
        ),
        // Expanded(child: Container())
        ImageIcon(AssetImage('images/logo.png'),size: 80,color: Color(0xFF399160),),
        Text("with blink", style: TextStyle(
            fontFamily: 'shabnam',
            fontSize: 20,
          color: Color(0xFF1C5334)
        )),
        Text("v 1.0.0",style: TextStyle(
            fontFamily: 'shabnam',
            fontSize: 20,
            color: Color(0xFF1C5334)

        ),)
      ],
    ),

  )
      : _currentIndex == 1?
  Container(

  ):
  Container(

  )
    );
  }

  void changeBottomIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
