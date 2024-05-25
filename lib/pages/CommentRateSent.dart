import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentRateSent extends StatelessWidget {
  const CommentRateSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/commentratesent.png",width: 300),
            const Text("نظر شما ثبت شد",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF236841)
            ),)
          ],
        ),
      ),
    );
  }
}
