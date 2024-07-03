import 'package:blink/pages/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomemrSuppoerScreen extends StatefulWidget {
  const CustomemrSuppoerScreen({super.key});

  @override
  State<CustomemrSuppoerScreen> createState() => _CustomemrSuppoerScreenState();
}

class _CustomemrSuppoerScreenState extends State<CustomemrSuppoerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("خوش اومدی کاستومر ساپورت :)",
            style: TextStyle(
              fontSize: 20,
            ),textDirection: TextDirection.rtl,),
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChatPage(isAdmin: true)));
            },
            child: Text(
              "   ورود به چت   ",
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
    );
  }
}
