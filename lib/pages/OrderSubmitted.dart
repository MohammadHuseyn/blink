import 'package:blink/pages/OrderStatus.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class OrderSubmitted extends StatefulWidget {
  const OrderSubmitted({super.key});

  @override
  State<OrderSubmitted> createState() => _OrderSubmittedState();
}

class _OrderSubmittedState extends State<OrderSubmitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>const Home()));
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF256F46),),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => OrderStatus()));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF256F46))
            ),
            child:const Text("   پیگیری سفارش   ",
              style: TextStyle(
                fontSize: 25,
              ),),
          ),
        ),
      ),
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
