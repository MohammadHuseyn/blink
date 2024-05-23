import 'package:blink/pages/Payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global.dart' as gloabl;

class LastCheck extends StatefulWidget {
  LastCheck({required this.sum});
  double sum;

  @override
  State<LastCheck> createState() => _LastCheckState();
}

class _LastCheckState extends State<LastCheck> {
  bool fast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              // try {
                var res = await gloabl.postRequest({
                  "location_id" : gloabl.addresses[gloabl.addressIndex].id,
                  "store_id" : gloabl.store_id,
                  "fast_delivery" : fast
                }, "/makeorder/");
                Map<String, dynamic> data = await res;
                gloabl.order_id = data["order_id"];
              // } catch(e) {}
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(sum: "120000")));
            },
            child: Text(
              "  پرداخت   ",
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
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(color: Colors.transparent),
                textDirection: TextDirection.rtl,
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        child: Text(
                          'نام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Text(
                          gloabl.first_name + " " + gloabl.last_name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        child: Text(
                          'شماره تلفن',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Text(
                          'قیمت',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        child: Text(
                          'آدرس',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Text(
                          gloabl.addresses[gloabl.addressIndex].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        child: Text(
                          'جمع کل',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Text(
                          (widget.sum + (fast? 50000 : 0)).toString() + " تومان",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تحویل فوری؟",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 25),
                    ),
                    Checkbox(
                        focusColor: Color(0xFF256F46),
                        activeColor: Color(0xFF256F46),
                        value: fast,
                        onChanged: (value) {
                          setState(() {
                            fast = value ?? false;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("با انتخاب گزینه بالا هزینه ارسال دوبرابر می‌شود\n اما سفارش در زمان کمتری به دستتان می‌رسد.",
                textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
