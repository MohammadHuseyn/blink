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
      appBar: AppBar(

        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications, size: 50,color: Color(0xFF256F46),))
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: IconButton(
            icon: Icon(Icons.location_on, size: 50, color: Color(0xFF256F46),),
            onPressed: () {},
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF256F46),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 30
      ),
      selectedIconTheme: IconThemeData(
        color: Color(0xFF256F46),
        size: 40
      ), currentIndex: _currentIndex,
      onTap: (index) {
          changeBottomIndex(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == 0? Colors.white : null,
              ),              child: ImageIcon(AssetImage('images/user2.png'))),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == 1? Colors.white : null,
              ),
              child: ImageIcon(AssetImage('images/home.png'))),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == 2? Colors.white : null,
            ),
              child: ImageIcon(AssetImage('images/cart.png'),)),
          label: '',
        ),
      ],
    ),
body: Container(

      ),
    );
  }

  void changeBottomIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
