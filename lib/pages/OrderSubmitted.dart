import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderSubmitted extends StatefulWidget {
  const OrderSubmitted({super.key});

  @override
  State<OrderSubmitted> createState() => _OrderSubmittedState();
}

class _OrderSubmittedState extends State<OrderSubmitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/blink.png",
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              const Text(
                "سفارش شما ثبت شد",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF236841), fontSize: 30, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ),
      )),
    );
  }
}
